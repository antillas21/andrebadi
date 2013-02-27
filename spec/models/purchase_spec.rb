require 'spec_helper'

describe Purchase do
  describe 'validations' do
    it { should validate_presence_of :purchase_date }
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :purchase_items }
  end

  describe '#total' do
    it 'represents an updated sum of purchase_items, directly from the relationship' do
      order = build(:purchase)
      coat, sweater = build(:coat), build(:sweater)

      order.purchase_items << coat
      order.purchase_items << sweater

      order.save
      order.total.should eql ( coat.item_total + sweater.item_total )
    end
  end

end

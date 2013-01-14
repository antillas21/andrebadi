require 'spec_helper'

describe Purchase do
  describe 'validations' do
    it { should validate_presence_of :purchase_date }
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :purchase_items }
  end

  describe 'purchase_total' do
    it 'represents the sum of purchase_items.item_total' do
      order = build(:purchase)
      coat, sweater = build(:coat), build(:sweater)

      order.purchase_items << coat
      order.purchase_items << sweater

      order.save
      order.reload
      order.purchase_total.should eql (sweater.item_total + coat.item_total)
    end
  end

end

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

  describe 'scopes' do
    describe 'recent' do
      it 'retrieves the 3 more recent purchases' do
        5.times { create(:purchase) }

        Purchase.recent.count.should eql 3
      end

      it 'retrieves records ordered by purchase_date in descending order' do
        first = create(:purchase, purchase_date: '2013-01-01')
        second = create(:purchase, purchase_date: '2013-02-01')
        third = create(:purchase, purchase_date: '2013-03-01')

        Purchase.recent.first.should eql third
      end
    end
  end


end

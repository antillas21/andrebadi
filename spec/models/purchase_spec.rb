require 'spec_helper'

describe Purchase do
 describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :line_items }
  end

  describe 'validations' do
    it { should validate_presence_of :amount }
    it { should validate_presence_of :customer_id }
  end

  describe 'amount' do
    let(:item) { build(:coat) }
    let(:purchase) { create(:purchase, line_items: [item]) }

    it 'is auto-calculated with the sum of all line_items' do
      # purchase = FactoryGirl.create(:purchase_and_items)
      purchase.amount.should_not == 0
      purchase.amount.should == 1200.0
    end
  end

  describe 'deleting a purchase' do
    let(:purchase) { create(:purchase) }

    it 'deletes associated line_items' do
      item = build(:coat, purchase: purchase)
      purchase.line_items << item
      purchase.save

      LineItem.count.should == 1
      purchase.line_items.should include item

      expect{ purchase.destroy }.to change{ LineItem.count }.to(0)
    end
  end

  describe 'role on customer balance' do
    let(:customer) { create(:customer) }
    let(:item) { build(:coat) }
    let(:purchase) { build(:purchase, customer: customer, line_items: [item]) }

    it 'updates customer balance' do
      expect{ purchase.save }.to change{ customer.balance }
    end
  end
end

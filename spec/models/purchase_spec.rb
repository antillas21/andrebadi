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
    it 'is auto-calculated with the sum of all line_items' do
      purchase = FactoryGirl.create(:purchase_and_items)
      purchase.amount.should_not == 0
      purchase.amount.should == 2400.0
    end
  end

  describe 'deleting a purchase' do
    it 'deletes associated line_items' do
      purchase = FactoryGirl.create(:purchase_and_items)

      LineItem.count.should == 2

      expect{ purchase.destroy }.to change{ LineItem.count }.to(0)
    end
  end

  describe 'role on customer balance' do
    let(:customer) { create(:customer) }
    it 'updates customer balance' do
      purchase = FactoryGirl.build(:purchase_and_items, customer: customer)
      expect{ purchase.save }.to change{ customer.balance }
    end
  end
end

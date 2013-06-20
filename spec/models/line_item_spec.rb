require 'spec_helper'

describe LineItem do
  describe 'validations' do
     it { should validate_presence_of :name }
    it { should validate_presence_of :qty }
    it { should validate_presence_of :price }
  end

  describe 'relationships' do
    it { should belong_to :purchase }
  end

  describe 'item_total' do
    it 'is auto-calculated' do
      item = FactoryGirl.create(:coat, qty: 3, price: 900.0)
      item.item_total.should == 2700.0
    end
  end
end

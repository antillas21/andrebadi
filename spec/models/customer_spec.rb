require 'spec_helper'

describe Customer do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :purchases }
    it { should have_many :payments }

    it { should belong_to :user }
  end

  describe '#total_purchases' do
    let(:customer) { create(:customer) }

    it 'returns sum of purchase amounts' do
      2.times { FactoryGirl.create(:purchase_and_items, customer: customer) }
      customer.total_purchases.should == 2400.0
    end
  end

  describe '#total_payments' do
    let(:customer) { create(:customer) }

    it 'returns sum of payment amounts' do
      2.times { create(:payment, amount: 900.0, customer: customer) }
      binding.pry
      customer.total_payments.should == 1800.0
    end
  end

  describe "#balance" do
    let(:customer) { create(:customer) }

    it 'returns balance between purchases and payments' do
      2.times { create(:purchase_and_items, customer: customer) }
      1.times { create(:payment, customer: customer) }

      customer.balance.should_not == 0

      customer.balance.should == ( customer.total_purchases - customer.total_payments )
    end
  end

end

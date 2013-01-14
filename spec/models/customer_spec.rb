require 'spec_helper'

describe Customer do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :balance }
  end

  describe 'relationships' do
    it { should have_many :purchases }
    it { should have_many :payments }

    it { should belong_to :user }
  end

  describe 'balance' do
    let(:customer) { create(:customer) }

    before :each do
      order_a = customer.purchases.build( attributes_for(:purchase) )
      order_a.purchase_items << build(:coat, item_total: 1000)

      order_a.save

      create(:payment, customer: customer, amount: 500) 
    end

    it 'represents difference between purchases.total and payments.total' do
      purchases_total = customer.purchases.pluck(:purchase_total).inject(0) { |sum, p| sum + p }
      payments_total = customer.payments.pluck(:amount).inject(0) { |sum, p| sum + p }

      customer.balance.should eql( purchases_total - payments_total )
    end

    it 'updates after every purchase made' do
      initial_balance = customer.balance
      order_b = customer.purchases.build( attributes_for(:purchase) )
      order_b.purchase_items << build(:sweater, item_total: 500)
      order_b.save

      customer.reload
      customer.balance.should_not eql initial_balance
    end

    it 'updates after every payment made' do
      initial_balance = customer.balance
      payment = customer.payments.create( attributes_for(:payment, amount: 300) )

      customer.reload
      customer.balance.should_not eql initial_balance
    end
  end
end

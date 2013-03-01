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

  describe '#last_payment' do
    let(:customer) { create(:customer) }

    it 'displays the latest payment from customer' do
      payment = create(:payment, customer: customer)
      last = create(:payment, customer: customer)

      customer.last_payment.should eql last
    end
  end

  describe '#recent_payments' do
    let(:customer) { create(:customer) }

    it 'retrieves the 3 more recent payments' do
      5.times { create(:payment, customer: customer) }
      customer.recent_payments.count.should eql 3
    end
  end

  describe '#recent_purchases' do
    let(:customer) { create(:customer) }

    it 'retrieves the 3 more recent purchases' do
      5.times { create(:purchase, customer: customer) }
      customer.recent_purchases.count.should eql 3
    end
  end

end

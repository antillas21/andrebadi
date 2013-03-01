require 'spec_helper'

describe Payment do
  describe 'validations' do
    it { should validate_presence_of :payment_date }
    it { should validate_presence_of :amount }
  end

  describe 'relationships' do
    it { should belong_to :customer }
  end

  describe 'scopes' do
    describe 'recent' do
      it 'retrieves the 3 more recent payments' do
        5.times { create(:payment) }

        Payment.recent.count.should eql 3
      end

      it 'retrieves records ordered by payment_date in descending order' do
        first = create(:payment, payment_date: '2013-01-01')
        second = create(:payment, payment_date: '2013-02-01')
        third = create(:payment, payment_date: '2013-03-01')

        Payment.recent.first.should eql third
      end
    end
  end

end

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
    it 'represents difference between purchases.total and payments.total'

    it 'updates after every purchase made'

    it 'updates after every payment made'
  end
end

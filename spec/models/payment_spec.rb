require 'spec_helper'

describe Payment do
  describe 'validations' do
    it { should validate_presence_of :payment_date }
    it { should validate_presence_of :amount }
  end

  describe 'relationships' do
    it { should belong_to :customer }
  end
end

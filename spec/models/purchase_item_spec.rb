require 'spec_helper'

describe PurchaseItem do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :qty }
    it { should validate_presence_of :item_total }
  end

  describe 'relationships' do
    it { should belong_to :purchase }
  end
end

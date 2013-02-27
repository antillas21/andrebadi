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
end

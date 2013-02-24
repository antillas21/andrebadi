require 'spec_helper'

describe Api::CustomersController do

  describe 'GET #index' do
    let(:user) { create(:user) }

    before :each do
      3.times { create(:customer, user: user) }

      sign_in user
      get 'index'
    end

    it 'should be success'

    it 'assigns :customers to current_user.customers' do
      assigns(:customers).should include @customers
    end
  end

end

require 'spec_helper'

describe Api::CustomersController, type: :api do
  let(:user) { create(:user) }
  let(:token) { user.authentication_token }
  # let(:customer) { create(:customer, user: user) }

  before :each do
    # @request.env["devise.mapping"] = Devise.mappings[:user]
    @customer = create(:customer, user: user)

    # sign_in user
    get 'index', token: token, format: :json
  end

  describe 'GET #index' do
   it 'should be success' do
      response.should be_success
    end

    it 'assigns :customers to logged_user.customers' do
      assigns(:customers).should include @customer
    end
  end

  describe 'GET #show' do
    before :each do
      get 'show', id: @customer.id, token: token, format: :json
    end

    it 'should be success' do
      response.should be_success
    end

    it 'assigns :customer to @customer, filtered from the logged_user' do
      assigns(:customer).should == @customer
    end
  end

  describe 'POST #create' do
    before :each do
      post 'create', 
        customer: { name: 'Janeth Doe', email: 'janeth@example.com' }, 
        token: token, format: :json
    end

    it 'is success' do
    end

    it 'assigns :customer to new current_user customer' do
      assigns(:customer).should_not be_nil
    end
  end

  describe 'PUT #update' do
    context 'valid attributes' do
      before :each do
        put 'update', id: @customer.id, customer: { name: 'Janeth Doe' }, 
          token: token, format: :json
      end

      it 'updates record in database' do
        @customer.reload
        @customer.name.should eql 'Janeth Doe'
      end

      it 'responds with updated record' do
        # response.should == '/api/customers/xyz'
      end
    end

    context 'invalid attributes' do
      before :each do
        put 'update', id: @customer.id, customer: { name: nil }, format: :json
      end

      it 'does not update record in database' do
        @customer.reload
        @customer.should_not be_changed
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      delete 'destroy', id: @customer.id, token: token, format: :json
    end

    it 'deletes record from database' do
      user.customers.should_not include @customer
    end
  end

end

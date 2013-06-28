require 'spec_helper'

describe Api::PurchasesController do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:customer) { create(:customer, user: user) }
  let(:token) { user.authentication_token }

  describe 'GET #index' do
    before do
      @purchase = create(:purchase, customer: customer)
      other_customer = create(:customer, user: other_user)
      @other_purchase = create(:purchase, customer: other_customer)
      get 'index', token: token, format: :json
    end

    it 'should be success' do
      response.should be_success
    end

    it 'retrieves all purchases from a user' do
      assigns(:purchases).should include @purchase
    end

    it 'does not include purchases that do not belong to a user' do
      assigns(:purchases).should_not include @other_purchase
    end
  end

  describe 'POST #create' do
  end

  describe 'GET #show' do
    let(:purchase) { create(:purchase, customer: customer) }

    before :each do
      get 'show', id: purchase.id, token: token, format: :json
    end

    it 'should be success' do
      response.should be_success
    end

    it 'assigns :purchase to purchase, filtered from the user providing the token' do
      assigns(:purchase).should == purchase
    end
  end

  describe 'PUT #update' do
    let(:purchase) { create(:purchase, customer: customer) }

    context 'valid attributes' do
      let(:other_customer) { create(:customer, user: user) }

      before :each do
        # binding.pry
        put 'update', id: purchase.id, purchase: {customer_id: other_customer.id},
          token: token, format: :json
      end

      it 'updates record in database' do
        purchase.reload
        purchase.customer.should eql other_customer
      end

      it 'responds with updated record' do
        response.location.should eql api_purchase_url(purchase)
      end
    end

    context 'invalid attributes' do
      before :each do
        put 'update', id: purchase.id, purchase: { customer_id: nil }, format: :json
      end

      it 'does not update record in database' do
        purchase.reload
        purchase.should_not be_changed
      end

      it 'returns an error' do
        response.status.should eql 204
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:purchase) { create(:purchase, customer: customer) }

    before :each do
      delete 'destroy', id: purchase.id, token: token, format: :json
    end

    it 'deletes record from database' do
      customer.purchases.should_not include purchase
    end
  end

end


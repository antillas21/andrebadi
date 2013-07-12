require 'spec_helper'

describe Api::PaymentsController do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:customer) { create(:customer, user: user) }
  let(:token) { user.authentication_token }
  let(:other_token) { other_user.authentication_token }

  describe 'GET #index' do
    before do
      @payment = create(:payment, customer: customer)
      other_customer = create(:customer, user: other_user)
      @other_payment = create(:payment, customer: other_customer)
      get 'index', token: token, format: :json
    end

    it 'should be success' do
      response.should be_success
    end

    it 'retrieves all payments from a user' do
      assigns(:payments).should include @payment
    end

    it 'does not include payments that do not belong to a user' do
      assigns(:payments).should_not include @other_payment
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new Payment for a given Customer' do
        post 'create', payment: { amount: 900, customer_id: customer.id}, token: token, format: :json
        response.should be_success
        Payment.count.should eq 1
      end
    end

    context 'with invalid attributes' do
      it 'returns an error message' do
        post 'create', payment: { amount: nil, customer_id: nil}, token: token, format: :json
        response.should_not be_success
        Payment.count.should eq 0
      end

      it 'returns an error when attempting to add payments for other users records' do
        post 'create', payment: { amount: 9000, customer_id: customer.id }, token: other_token, format: :json

        json_error = JSON.parse(response.body)
        json_error.values.should include("customer_id value does not belong to any Customer on your records. Operation not allowed.")
        response.status.should == 403
      end
    end
  end

  describe 'GET #show' do
    let(:payment) { create(:payment, customer: customer) }

    before :each do
      get 'show', id: payment.id, token: token, format: :json
    end

    it 'should be success' do
      response.should be_success
    end

    it 'assigns :payment to payment, filtered from the user providing a token' do
      assigns(:payment).should == payment
    end
  end

  describe 'PUT #update' do
    let(:payment) { create(:payment, customer: customer) }

    context 'valid attributes' do
      before :each do
        put 'update', id: payment.id, payment: { amount: 7000.0, customer_id: customer.id },
          token: token, format: :json
      end

      it 'updates record in database' do
        payment.reload
        payment.amount.should eql 7000.0
      end

      it 'responds with updated record' do
        response.location.should eql api_payment_url(payment)
      end
    end

    context 'invalid attributes' do
      before :each do
        put 'update', id: payment.id, payment: { amount: nil }, format: :json,
          token: token
      end

      it 'does not update record in database' do
        payment.reload
        payment.should_not be_changed
      end

      it 'returns an error' do
        response.status.should eql 422
      end

      it 'does not allow to update payments for Customers that do not belong to User' do
        put 'update', id: payment.id, payment: { amount: 300, customer_id: customer.id},
          token: other_token, format: :json

        response.status.should eq 403
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:payment) { create(:payment, customer: customer) }

    before :each do
      delete 'destroy', id: payment.id, token: token, format: :json
    end

    it 'deletes record from database' do
      customer.payments.should_not include payment
    end
  end

end

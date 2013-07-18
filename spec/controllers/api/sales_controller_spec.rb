require 'spec_helper'

describe Api::SalesController do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:customer) { create(:customer, user: user) }
  let(:token) { user.authentication_token }
  let(:other_token) { other_user.authentication_token }

  describe 'GET #index' do
    before do
      @sale = create(:sale, customer: customer)
      other_customer = create(:customer, user: other_user)
      @other_sale = create(:sale, customer: other_customer)
      get 'index', token: token, format: :json
    end

    it 'should be success' do
      response.should be_success
    end

    it 'retrieves all sales from a user' do
      assigns(:sales).should include @sale
    end

    it 'does not include sales that do not belong to a user' do
      assigns(:sales).should_not include @other_sale
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:coat) { attributes_for(:coat, cost: 400, price: 900) }
      it ' creates a new sale for a given Customer' do
        post 'create', sale: { customer_id: customer.id, line_items_attributes: [coat]}, token: token, format: :json
        response.should be_success
        Sale.count.should eq 1
        LineItem.count.should eq 1
      end
    end

    context 'with invalid params' do
      let(:coat) { attributes_for(:coat, cost: 400, price: 900) }

      it 'does not allow to create a sale if Customer record does not belong to user' do
        post 'create', sale: { customer_id: customer.id, line_items_attributes: [coat] },
          token: other_token, format: :json

        response.should_not be_success
        Sale.count.should eq 0
        LineItem.count.should eq 0
      end
    end
  end

  describe 'GET #show' do
    let(:sale) { create(:sale, customer: customer) }

    before :each do
      get 'show', id: sale.id, token: token, format: :json
    end

    it 'should be success' do
      response.should be_success
    end

    it 'assigns :sale to sale, filtered from the user providing the token' do
      assigns(:sale).should == sale
    end
  end

  describe 'PUT #update' do
    let(:sale) { create(:sale, customer: customer) }

    context 'valid attributes' do
      let(:other_customer) { create(:customer, user: user) }

      before :each do
        # binding.pry
        put 'update', id: sale.id, sale: {customer_id: other_customer.id},
          token: token, format: :json
      end

      it 'updates record in database' do
        sale.reload
        sale.customer.should eql other_customer
      end

      it 'responds with updated record' do
        response.location.should eql api_sale_url(sale)
      end
    end

    context 'invalid attributes' do
      before :each do
        put 'update', id: sale.id, sale: { customer_id: nil }, format: :json
      end

      it 'does not update record in database' do
        sale.reload
        sale.should_not be_changed
      end

      it 'returns an error' do
        response.status.should eql 204
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:sale) { create(:sale, customer: customer) }

    before :each do
      delete 'destroy', id: sale.id, token: token, format: :json
    end

    it 'deletes record from database' do
      customer.sales.should_not include sale
    end
  end

end


require 'spec_helper'

describe Api::LineItemsController do
  let(:user) { create(:user) }
  let(:customer) { create(:customer, user: user) }
  let(:sale) { create(:sale, customer: customer) }
  let(:token) { user.authentication_token }

  describe 'POST #create' do
    context 'with valid params' do
      it 'should create a new LineItem that belongs to a given sale' do
        post 'create', token: token, format: :json,
          line_item: { sale_id: sale.id, name: 'Coat', qty: 1, price: 900, cost: 100 }
        LineItem.count.should eq 1
        sale.reload
        sale.line_items.count.should eq 1
      end
    end

    context 'with invalid params' do
      it 'does not create a LineItem if no sale_id is given' do
        post 'create', token: token, format: :json,
          line_item: { name: 'Coat', qty: 1, price: 900, cost: 100 }
        LineItem.count.should eq 0
        sale.reload
        sale.line_items.count.should eq 0

        json_response = JSON.parse(response.body)
        json_response.keys.should include 'error'
      end
    end
  end

  describe 'GET #show' do
    let(:item) { create(:coat, sale_id: sale.id) }

    it 'retrieves a LineItem' do
      get 'show', line_item: { sale_id: sale.id }, id: item.id, format: :json, token: token
      response.should be_success
    end

    it 'assigns a LineItem record to line_item' do
      get 'show', line_item: { sale_id: sale.id }, id: item.id, format: :json, token: token
      assigns(:item).should == item
    end
  end

  describe 'PUT #update' do
    let(:item) { create(:coat, sale_id: sale.id) }

    context 'valid attributes' do
      before :each do
        put 'update', id: item.id, line_item: { name: 'Scarf' },
          token: token, format: :json
      end

      it 'updates record in database' do
        item.reload
        item.name.should eql 'Scarf'
      end

      it 'responds with updated record' do
        response.location.should eql api_line_item_url(item)
      end
    end

    context 'invalid attributes' do
      before :each do
        put 'update', id: item.id, line_item: { price: nil }, format: :json
      end

      it 'does not update record in database' do
        item.reload
        item.should_not be_changed
      end

      it 'returns an error' do
        response.status.should eql 204
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:item) { create(:coat, sale_id: sale.id) }

    before :each do
      delete 'destroy', id: item.id, token: token, format: :json
    end

    it 'deletes record from database' do
      sale.line_items.should_not include item
    end
  end

end

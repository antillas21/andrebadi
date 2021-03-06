require 'spec_helper'

describe Api::BaseController do
  describe "API errors", type: :api do
    it 'displays an error if no token is provided' do
      get '/api/customers.json', token: ""
      error = { error: "Token is missing or is invalid." }
      last_response.body.should eql error.to_json
    end

    it "displays an error if no customer record is found" do
      user = create(:user)
      token = user.authentication_token
      customer = create(:customer)

      get "/api/customers/#{customer.id}.json", token: token
      error = { error: "Record could not be found or access not allowed." }
      last_response.body.should eql error.to_json
    end

    it 'displays an error if no payment record is found' do
      user = create(:user)
      token = user.authentication_token
      customer = create(:customer, user: user)
      nil_customer = create(:customer)
      payment = create(:payment, customer: nil_customer)

      get "/api/payments/#{payment.id}.json", token: token
      error = { error: "Record could not be found or access not allowed." }
      last_response.body.should eql error.to_json
    end
  end
end

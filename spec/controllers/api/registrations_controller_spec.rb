require 'spec_helper'

describe Api::RegistrationsController do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe '#create' do
    context 'with valid params' do
      it 'should create a new User' do
        post :create,
          user: {email: 'user@example.com', password: 'password', password_confirmation: 'password'},
          format: :json

        json = JSON.parse(response.body)
        ["email", "authentication_token"].each do |key|
          json.keys.should include key
        end

        response.status.should == 201

      end
    end

    context 'with invalid params' do
    end
  end
end

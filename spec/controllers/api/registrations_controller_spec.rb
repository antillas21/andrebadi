require 'spec_helper'

describe Api::RegistrationsController do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe '#create' do
    context 'with valid params' do
      it 'should create a new User' do
        binding.pry
        post :create, user: {email: 'user@example.com', password: 'password', password_confirmation: 'password'}, format: :json
        response.status.should == 422
      end
    end

    context 'with invalid params' do
    end
  end
end

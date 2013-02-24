require 'spec_helper'

describe Api::BaseController do
  describe "API errors", type: :api do
    it 'displays an error if no token is provided' do
      get '/api/customers.json', token: ""
      error = { error: "Token is missing or is invalid." }
      last_response.body.should eql error.to_json
    end
  end
end

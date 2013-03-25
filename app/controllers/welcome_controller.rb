class WelcomeController < ApplicationController
  before_filter :authenticate_user!

  def backbone
    @token = current_user.id
    @customers = current_user.customers.order(:name).all
  end

  def customers
  end

  def payments
    
  end
end

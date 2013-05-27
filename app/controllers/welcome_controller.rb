class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  layout 'bootstrap'

  def index
    gon.currentUser = current_user
  end

  def backbone
    @token = current_user.id
    @customers = current_user.customers.order(:name).all
  end

  def customers
  end

  def payments

  end
end

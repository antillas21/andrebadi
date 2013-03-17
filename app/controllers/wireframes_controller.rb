class WireframesController < ApplicationController

  def customers
    @customers = current_user.customers.includes(:payments).order(:name)
  end

  def customer
    @customer = current_user.customers.find(params[:id])
  end

end

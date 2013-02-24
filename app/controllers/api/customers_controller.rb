class Api::CustomersController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  def index
    @customers = current_user.customers
    respond_with @customers
  end

  def show
    @customer = current_user.customers.find(params[:id])
    respond_with @customer
  end

  def update
    @customer = current_user.customers.find(params[:id])
    @customer.update_attributes(params[:customer])
    respond_with @customer
  end

  def destroy
    @customer = current_user.customers.find(params[:id])
    @customer.destroy
    head :ok
  end
end

class Api::CustomersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :retrieve_customer, only: [ :show, :update, :destroy ]

  respond_to :json

  def index
    @customers = current_user.customers
    respond_with @customers
  end

  def create
    @customer = current_user.customers.create(params[:customer])
    respond_with @customer, location: api_customers_url
  end

  def show
    respond_with @customer
  end

  def update
    @customer.update_attributes(params[:customer])
    respond_with @customer
  end

  def destroy
    @customer.destroy
    head :ok
  end

  private
  def retrieve_customer
    @customer = current_user.customers.find(params[:id])
  end
end

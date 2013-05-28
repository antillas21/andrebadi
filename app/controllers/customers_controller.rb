class CustomersController < ApplicationController
  respond_to :json

  before_filter :retrieve_customer, only: [ :show, :update, :destroy ]

  def index
    @customers = current_user.customers.order(:name)
    respond_with @customers
  end

  def create
    @customer = current_user.customers.create(params[:customer])
    if @customer.valid?
      respond_with @customer
    else
      respond_with @customer
    end
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
  rescue ActiveRecord::RecordNotFound
    error = { error: "Record could not be found or access not allowed." }
    respond_with(error, status: 404)
  end
end

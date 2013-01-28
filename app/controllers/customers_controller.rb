class CustomersController < ApplicationController
  respond_to :html, :json

  def index
    respond_with(@customers = Customer.all)
  end

  def create
    @customer = Customer.new(valid_params)

    if @customer.save
      respond_with(@customer)
    else
      respond_with(@customer, status: :unprocessable_entity)
    end
  end

  private
  def valid_params
    params.require(:customer).permit(
      :name, :user_id, :email, :balance, :phone
    )
  end
end

class Api::PaymentsController < Api::BaseController
  before_filter :find_customer
  before_filter :find_payment, only: [:show, :update, :destroy]

  def index
    @payments = @customer.payments
    respond_with @payments
  end

  def show
    respond_with @payment
  end

  def update
    @payment.update_attributes(params[:payment])
    respond_with @payment, location: api_customer_payment_url(@payment)
  end

  def destroy
    @payment.destroy
    head :ok
  end

  private
  def find_customer
    @customer = Customer.find(params[:customer_id])
  end

  def find_payment
    @payment = @customer.payments.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      error = { error: "Record could not be found or access not allowed." }
      respond_with(error, status: 404)
  end
end

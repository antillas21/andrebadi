class Api::PaymentsController < Api::BaseController
  before_filter :find_payment, only: [:show, :update, :destroy]
  before_filter :find_customer, only: [:create]

  def index
    @payments = logged_user.payments
    respond_with @payments.includes(:customer)
  end

  def create
    @payment = @customer.payments.new(accepted_params)
    @payment.save
    respond_with @payment, location: api_payment_url(@payment)
  end

  def show
    respond_with @payment
  end

  def update
    @payment.update_attributes(accepted_params)
    respond_with @payment, location: api_payment_url(@payment)
  end

  def destroy
    @payment.destroy
    head :ok
  end

  private
  def find_payment
    @payment = logged_user.payments.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      error = { error: "Record could not be found or access not allowed." }
      render json: error, status: 403, location: api_payment_url
  end

  def find_customer
    @customer = logged_user.customers.find(accepted_params[:customer_id])
    rescue ActiveRecord::RecordNotFound
      error = { error: "customer_id value does not belong to any Customer on your records. Operation not allowed."}
      respond_with error, status: 403, location: api_payments_url
  end

  def accepted_params
    params.require(:payment).permit(:amount, :customer_id)
  end
end

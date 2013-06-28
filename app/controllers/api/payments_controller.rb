class Api::PaymentsController < Api::BaseController
  before_filter :find_payment, only: [:show, :update, :destroy]

  def index
    @payments = logged_user.payments
    respond_with @payments
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
      respond_with(error, status: 404)
  end

  def accepted_params
    params.require(:payment).permit(:amount, :customer_id)
  end
end

class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_payment, only: [:show, :edit, :update, :destroy, :send_by_email]
  before_filter :find_customer, only: [:new, :create]

  def index
    @payments = current_user.payments
  end

  def new
    @payment = @customer.payments.new
  end

  def create
    @payment = @customer.payments.new(accepted_params)
    if @payment.save
      redirect_to @payment, notice: 'Successfully created payment.'
    else
      render :new
    end
  end

  def show
    @customer = @payment.customer
  end

  def edit
  end

  def update
    if @payment.update_attributes(accepted_params)
      redirect_to @payment, notice: 'Successfully updated payment.'
    else
      render :edit
    end
  end

  def destroy
    @customer = @payment.customer
    @payment.destroy
    redirect_to @customer, notice: 'Successfully deleted payment.'
  end

  def send_by_email
    TransactionMailer.receipt( @payment, @payment.customer, current_user ).deliver
    redirect_to @payment, notice: 'Payment Receipt has been queued for delivery.'
  end

  private
  def find_payment
    @payment = current_user.payments.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render '/public/404.html'
  end

  def find_customer
    @customer = current_user.customers.find(params[:customer_id])
    rescue ActiveRecord::RecordNotFound
      render '/public/404.html'
  end

  def accepted_params
    params.require(:payment).permit(:amount, :customer_id)
  end
end

class Api::CustomersController < Api::BaseController
  before_filter :retrieve_customer, only: [ :show, :update, :destroy ]

  respond_to :json

  def index
    @customers = logged_user.customers
    respond_with @customers.order(:name).includes(:payments),
      methods: [ "last_payment"]
  end

  def create
    @customer = logged_user.customers.create(params[:customer])
    if @customer.valid?
      respond_with @customer, location: api_customer_url(@customer)
    else
      respond_with @customer
    end
  end

  def show
    respond_with @customer, methods: [ "recent_payments", "recent_purchases" ]
  end

  def update
    @customer.update_attributes(params[:customer])
    respond_with @customer, location: api_customer_url(@customer)
  end

  def destroy
    @customer.destroy
    head :ok
  end

  private
  def retrieve_customer
    @customer = logged_user.customers.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    error = { error: "Record could not be found or access not allowed." }
    respond_with(error, status: 404)
  end
end

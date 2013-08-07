class Api::SalesController < Api::BaseController
  before_filter :find_sale, only: [:show, :update, :destroy, :send_by_email]
  before_filter :find_customer, only: [:create]

  def index
    @sales = logged_user.sales
    respond_with @sales.includes(:customer, :line_items)
  end

  def show
    respond_with @sale
  end

  def create
    @sale = @customer.sales.new(accepted_params)
    @sale.save
    respond_with @sale, location: api_sale_url(@sale)
  end

  def update
    @sale.update_attributes(accepted_params)
    respond_with @sale, location: api_sale_url(@sale)
  end

  def destroy
    @sale.destroy
    head :ok
  end

  def send_by_email
    # @sale.email_to_owner!
    SalesMailer.invoice( @sale, @sale.customer, logged_user ).deliver
    message = { message: "We need to implement a send by email method in the model now."}
    respond_with message.to_json, location: email_api_sale_url(@sale), status: 200
  end

  private
  def find_sale
    @sale = logged_user.sales.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      error = { error: "Record could not be found or access not allowed." }
      respond_with(error, status: 404)
  end

  def find_customer
    @customer = logged_user.customers.find(accepted_params[:customer_id])
    rescue ActiveRecord::RecordNotFound
      error = { error: "customer_id value does not belong to any Customer in your account."}
      render json: error, status: 403, location: api_sales_url
  end

  def accepted_params
    params.require(:sale).permit(
      :amount, :customer, :customer_id,
      line_items_attributes: [:name, :color, :size, :cost, :price, :qty]
    )
  end
end

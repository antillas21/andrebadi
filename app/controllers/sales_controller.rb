class SalesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_sale, only: [:show, :edit, :update, :destroy, :send_by_email]
  before_action :find_customer, only: [:new, :create]

  def index
    @sales = current_user.sales
  end

  def show
    @customer = @sale.customer
    @items = @sale.line_items
  end

  def new
    @sale = @customer.sales.new
  end

  def create
    @sale = @customer.sales.new(accepted_params)
    if @sale.save
      redirect_to @sale
    else
      render :new
    end
  end

  def edit
    @customer = @sale.customer
  end

  def update
    if @sale.update_attributes(accepted_params)
      redirect_to @sale, notice: 'Successfully updated sale.'
    else
      render :edit
    end
  end

  def destroy
    @customer = @sale.customer
    @sale.destroy
    redirect_to @customer, notice: 'Successfully deleted sale.'
  end

  def send_by_email
    TransactionMailer.invoice( @sale, @sale.customer, current_user ).deliver
    redirect_to @sale, notice: 'Invoice has been queued for delivery.'
  end

  private
  def find_sale
    @sale = current_user.sales.includes(:line_items).find(params[:id])
    rescue ActiveRecord::RecordNotFound
      # error = { error: "Record could not be found or access not allowed." }
      # respond_with(error, status: 404)
  end

  def find_customer
    @customer = current_user.customers.find(accepted_params[:customer_id])
    rescue ActiveRecord::RecordNotFound
      # error = { error: "customer_id value does not belong to any Customer in your account."}
      # render json: error, status: 403, location: api_sales_url
  end

  def accepted_params
    params.require(:sale).permit(
      :amount, :customer, :customer_id,
      line_items_attributes: [:name, :color, :size, :cost, :price, :qty]
    )
  end
end

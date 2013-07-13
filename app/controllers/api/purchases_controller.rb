class Api::PurchasesController < Api::BaseController
  before_filter :find_purchase, only: [:show, :update, :destroy]
  before_filter :find_customer, only: [:create]

  def index
    @purchases = logged_user.purchases
    respond_with @purchases.includes(:customer, :line_items)
  end

  def show
    respond_with @purchase
  end

  def create
    @purchase = @customer.purchases.new(accepted_params)
    @purchase.save
    respond_with @purchase, location: api_purchase_url(@purchase)
  end

  def update
    @purchase.update_attributes(accepted_params)
    respond_with @purchase, location: api_purchase_url(@purchase)
  end

  def destroy
    @purchase.destroy
    head :ok
  end

  private
  def find_purchase
    @purchase = logged_user.purchases.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      error = { error: "Record could not be found or access not allowed." }
      respond_with(error, status: 404)
  end

  def find_customer
    @customer = logged_user.customers.find(accepted_params[:customer_id])
    rescue ActiveRecord::RecordNotFound
      error = { error: "customer_id value does not belong to any Customer in your account."}
      render json: error, status: 403, location: api_purchases_url
  end

  def accepted_params
    params.require(:purchase).permit(
      :amount, :customer, :customer_id,
      line_items_attributes: [:name, :color, :size, :cost, :price, :qty]
    )
  end
end

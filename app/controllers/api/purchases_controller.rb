class Api::PurchasesController < Api::BaseController
  before_filter :find_purchase, only: [:show, :update, :destroy]

  def index
    @purchases = logged_user.purchases
    respond_with @purchases.includes(:customer, :line_items)
  end

  def show
    respond_with @purchase
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

  def accepted_params
    params.require(:purchase).permit(:amount, :customer, :customer_id, :line_items_attributes, :line_items)
  end
end

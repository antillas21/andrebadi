class Api::LineItemsController < Api::BaseController
  before_action :find_sale, only: [:create]
  before_action :find_line_item, only: [:show, :update, :destroy]

  respond_to :json

  def create
    @item = @sale.line_items.create(accepted_params)

    if @item.valid?
      respond_with @item, location: api_line_item_url( @item )
    else
      respond_with @item
    end
  end

  def show
    respond_with @item, location: api_line_item_url(@item)
  end

  def update
    @item.update_attributes( accepted_params )
    respond_with @item, location: api_line_item_url(@item)
  end

  def destroy
    @item.destroy
    head :ok
  end

  private
  def find_line_item
    @item = logged_user.line_items.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      error = { error: "Record could not be found or access not allowed." }
      render json: error, status: 403, location: api_line_items_url
  end

  def find_sale
    @sale = logged_user.sales.find(accepted_params[:sale_id])
    rescue ActiveRecord::RecordNotFound
      error = { error: "sale_id value does not belong to any Sale on your records. Operation not allowed."}
      respond_with error, status: 403, location: api_line_items_url
  end

  def accepted_params
    params.require(:line_item).permit(:id, :name, :qty, :color, :size, :price, :cost, :sale_id)
  end

end

class LineItemsController < ApplicationController
  before_action :find_sale, only: [:create]
  before_action :find_line_item, only: [:show, :update, :destroy]

  def create
    @item = @sale.line_items.new(accepted_params)

    if @item.save
      redirect_to @sale, notice: 'Added an item.'
    else
      redirect_to @sale, error: 'Fix any errors present.'
    end
  end


  def update
    @item.update_attributes(accepted_params)
    redirect_to @sale, notice: 'Updated item.'
  end

  def destroy
    @sale = @item.sale
    @item.destroy
    redirect_to @sale, notice: 'Removed item from sale.'
  end

  private
  def find_line_item
    @item = current_user.line_items.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render '/public/404.html'
  end

  def find_sale
    @sale = current_user.sales.find(accepted_params[:sale_id])
    rescue ActiveRecord::RecordNotFound
      render '/public/404.html'
  end

  def accepted_params
    params.require(:line_item).permit(:id, :name, :qty, :color, :size, :price, :cost, :sale_id)
  end
end
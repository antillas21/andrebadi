class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_filter :retrieve_customer, only: [ :show, :edit, :update, :destroy ]

  def index
    @customers = current_user.customers.order(:name)
    if params[:query]
      @customers = @customers.where("name ILIKE ?", "%#{params[:query]}%")
    end
    @customers
  end

  def new
    @customer = current_user.customers.new
  end

  def create
    @customer = current_user.customers.create(accepted_params)
    if @customer.save
      redirect_to @customer, notice: 'Saved successfully'
    else
      render :new
    end
  end

  def show
    @transactions = @customer.transactions.order("created_at DESC")
  end

  def edit
    
  end

  def update
    if @customer.update_attributes(accepted_params)
      redirect_to @customer, notice: 'Successfully updated'
    else
      render :show
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: 'Successfully deleted customer.'
  end

  private
  def retrieve_customer
    @customer = current_user.customers.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render '/public/404.html'
  end

  def accepted_params
    params.require(:customer).permit(:name, :email, :phone, :balance)
  end
  
end

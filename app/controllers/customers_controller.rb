class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_filter :retrieve_customer, only: [ :show, :edit, :update, :destroy ]

  def index
    @customers = current_user.customers
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
    # if @customer.valid?
    #   respond_with @customer, location: api_customer_url(@customer)
    # else
    #   respond_with @customer
    # end
  end

  def show
    # respond_with @customer
  end

  def edit
    
  end

  def update
    if @customer.update_attributes(accepted_params)
      redirect_to @customer, notice: 'Successfully updated'
    else
      render :edit
    end
    # respond_with @customer, location: api_customer_url(@customer)
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: 'Successfully deleted customer.'
  end

  private
  def retrieve_customer
    @customer = current_user.customers.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    # error = { error: "Record could not be found or access not allowed." }
    # respond_with(error, status: 404)
  end

  def accepted_params
    params.require(:customer).permit(:name, :email, :phone, :balance)
  end
  
end

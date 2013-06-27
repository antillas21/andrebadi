class Api::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  # skip_filter :authenticate_user

  def create
    @user = User.new(params[:user])
    if @user.save
      # render :json=> @user.as_json(auth_token: @user.authentication_token, email: @user.email), status: 201
      render json: {
        id: @user.id, email: @user.email,
        authentication_token: @user.authentication_token,
        created_at: @user.created_at, updated_at: @user.updated_at
        }, status: 201
      return
    else
      warden.custom_failure!
      message = "There are some errors with your request."
      render json: { message: message, errors: @user.errors }, status: 422
      # respond_with @user, status: 422
      # render :json=> user.errors, :status=>422
    end
  end

end

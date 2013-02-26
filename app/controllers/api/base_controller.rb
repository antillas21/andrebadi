class Api::BaseController < ActionController::Base

  respond_to :json

  before_filter :authenticate_user

  private
  def authenticate_user
    @logged_user = User.where(authentication_token: params[:token]).first
    respond_with({ error: "Token is missing or is invalid." })  unless @logged_user
  end

  def logged_user
    @logged_user
  end
end

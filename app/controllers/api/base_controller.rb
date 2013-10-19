class Api::BaseController < ActionController::Base

  respond_to :json

  before_filter :authenticate_user
  prepend_before_filter :get_auth_token

  private
  def get_auth_token
    if params[:token].blank? && request.headers['X-AUTH-TOKEN']
      params[:token] = request.headers['X-AUTH-TOKEN']
    end
  end

  def authenticate_user
    @logged_user = User.where(authentication_token: params[:token]).first
    respond_with({ error: "Token is missing or is invalid." })  unless @logged_user
  end

  def logged_user
    @logged_user
  end
end

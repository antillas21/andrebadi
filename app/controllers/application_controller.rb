class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'bootstrap'

  def after_sign_in_path_for(resource)
    customers_path
  end

  def user_settings
    current_user.account_setting
  end

  helper_method :user_settings

  def tracking_costs
    user_settings.track_cost?
  end

  helper_method :tracking_costs

end

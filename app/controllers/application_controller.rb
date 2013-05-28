class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'bootstrap'

  def after_sign_in_path_for(resource)
    '/#dashboard'
  end
end

class WelcomeController < ApplicationController
  before_filter :authenticate_user!

  def backbone
    @token = current_user.id
  end
end

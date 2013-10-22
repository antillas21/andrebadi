class AccountSettingsController < ApplicationController
  def edit
    @settings = current_user.account_setting
  end

  def update
    @settings = current_user.account_setting
    if @settings.update_attributes(accepted_params)
      redirect_to edit_account_setting_path(@settings.id), notice: 'Updated settings.'
    else
      render :edit, error: 'Please correct any errors present.'
    end
  end

private
  def accepted_params
    params.require(:account_setting).permit(:store_name, :language, :track_cost)
  end
end

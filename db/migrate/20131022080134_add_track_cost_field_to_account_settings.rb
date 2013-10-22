class AddTrackCostFieldToAccountSettings < ActiveRecord::Migration
  def change
    add_column :account_settings, :track_cost, :boolean, default: true

    AccountSetting.find_each do |act_setting|
      act_setting.update_attribute(:track_cost, true)
    end
  end
end

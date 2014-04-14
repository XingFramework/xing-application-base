class AddMailerSettingToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :mailer_setting, :integer
  end

  def self.down
    remove_column :users, :mailer_setting
  end
end

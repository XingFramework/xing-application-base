class AddPlatformOptionsToStudies < ActiveRecord::Migration
  def self.up
    add_column :studies, :platform_web, :boolean, :null => false, :default => true
    add_column :studies, :platform_ios, :boolean, :null => false, :default => true
    add_column :studies, :platform_android, :boolean, :null => false, :default => true
  end

  def self.down
    remove_column :studies, :platform_android
    remove_column :studies, :platform_ios
    remove_column :studies, :platform_web
  end
end

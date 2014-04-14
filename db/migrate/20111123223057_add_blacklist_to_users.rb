class AddBlacklistToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :blacklist, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :users, :blacklist
  end
end

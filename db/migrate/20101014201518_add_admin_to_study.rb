class AddAdminToStudy < ActiveRecord::Migration
  def self.up
    add_column :studies, :admin, :boolean
  end

  def self.down
    remove_column :studies, :admin
  end
end

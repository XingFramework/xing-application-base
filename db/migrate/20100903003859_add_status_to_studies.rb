class AddStatusToStudies < ActiveRecord::Migration
  def self.up
    add_column :studies, :status, :integer, :default => 0
    add_index :studies, :status
  end

  def self.down
    remove_column :studies, :status
  end
end

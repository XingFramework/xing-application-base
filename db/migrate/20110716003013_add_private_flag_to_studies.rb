class AddPrivateFlagToStudies < ActiveRecord::Migration
  def self.up
    add_column :studies, :private, :boolean, :default => false
    
    add_index :studies, :private
  end

  def self.down
    remove_column :studies, :private
  end
end

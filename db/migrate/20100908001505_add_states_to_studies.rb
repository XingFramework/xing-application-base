class AddStatesToStudies < ActiveRecord::Migration
  def self.up
    add_column :studies, :states, :text
    add_column :studies, :countries, :text
    add_column :studies, :regions, :text
  end

  def self.down
    remove_column :studies, :countries
    remove_column :studies, :states
    remove_column :studies, :regions
  end
end

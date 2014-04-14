class AddSingleServeToStudies < ActiveRecord::Migration
  def self.up
    add_column :studies, :single_serve, :boolean

    add_index :studies, :single_serve
  end

  def self.down
    remove_column :studies, :single_serve
  end
end

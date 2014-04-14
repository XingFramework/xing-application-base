class AddPolyOwnerToTransaction < ActiveRecord::Migration
  def self.up
    add_column :transactions, :study_id, :integer
    add_column :transactions, :category, :integer
  end

  def self.down
    remove_column :transactions, :study_id
    remove_column :transactions, :category
  end
end

class AddOwnerToTransaction < ActiveRecord::Migration
  def self.up
    remove_column :transactions, :researcher_id
    
    add_column :transactions, :user_id, :integer
    add_column :transactions, :method, :string
    add_column :transactions, :reference, :string
    add_column :transactions, :authorization, :string    
  end

  def self.down
    add_column :transactions, :researcher_id, :integer
    
    remove_column :transactions, :user_id
    remove_column :transactions, :method
    remove_column :transactions, :reference
    remove_column :transactions, :authorization
  end
end

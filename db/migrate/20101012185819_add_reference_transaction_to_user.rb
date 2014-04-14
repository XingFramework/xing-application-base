class AddReferenceTransactionToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :reference_transaction, :string
  end

  def self.down
    remove_column :users, :reference_transaction
  end
end

class AddReferenceTransactionToCreditCard < ActiveRecord::Migration
  def self.up
    add_column :credit_cards, :reference_transaction, :string
  end

  def self.down
    remove_column :credit_cards, :reference_transaction
  end
end

class RemoveBillingInfoFromUser < ActiveRecord::Migration
  def self.up    
    remove_column :users, :billing_credit_card
    remove_column :users, :billing_expiration_month
    remove_column :users, :billing_expiration_year
    remove_column :users, :billing_address
    remove_column :users, :billing_city
    remove_column :users, :billing_state
    remove_column :users, :billing_zip    
  end

  def self.down
    add_column :users, :billing_credit_card, :string
    add_column :users, :billing_expiration_month, :string
    add_column :users, :billing_expiration_year, :string
    add_column :users, :billing_address, :string
    add_column :users, :billing_city, :string
    add_column :users, :billing_state, :string
    add_column :users, :billing_zip, :string
  end  
end

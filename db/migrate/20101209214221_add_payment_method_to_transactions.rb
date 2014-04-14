class AddPaymentMethodToTransactions < ActiveRecord::Migration
  def self.up
    rename_column :transactions, :method, :payment_method
  end

  def self.down
    rename_column :transactions, :payment_method, :method
  end
end

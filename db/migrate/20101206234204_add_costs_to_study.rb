class AddCostsToStudy < ActiveRecord::Migration
  def self.up    
    add_column :studies, :admin_fee, :integer
    add_column :studies, :application_fee, :integer
    add_column :studies, :pay_rate, :integer
  end

  def self.down
    remove_column :studies, :pay_rate
    remove_column :studies, :application_fee
    remove_column :studies, :admin_fee    
  end
end

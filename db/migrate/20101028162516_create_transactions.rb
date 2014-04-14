class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :researcher_id
      t.integer :what_id
      t.string :what_type
      t.integer :amount
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end

class CreateCreditCards < ActiveRecord::Migration
  def self.up
    create_table :credit_cards do |t|
      t.integer :researcher_id
      t.string :first_name
      t.string :last_name
      t.string :number
      t.string :month
      t.string :year
      t.string :ctype
      t.string :cvv
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip

      t.timestamps
    end
  end

  def self.down
    drop_table :credit_cards
  end
end

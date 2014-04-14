class CreateHits < ActiveRecord::Migration
  def self.up
    create_table :hits do |t|
      t.integer :user_id
      t.string :ip
      t.text :request
      t.text :params

      t.timestamps
    end
  end

  def self.down
    drop_table :hits
  end
end

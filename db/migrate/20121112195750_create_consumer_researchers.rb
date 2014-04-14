class CreateConsumerResearchers < ActiveRecord::Migration
  def self.up
    create_table :consumer_researchers do |t|
      t.integer :consumer_id
      t.integer :researcher_id

      t.timestamps
    end

    add_index :consumer_researchers, :consumer_id
    add_index :consumer_researchers, :researcher_id

  end

  def self.down
    drop_table :consumer_researchers
  end
end

class CreateDemoResponses < ActiveRecord::Migration
  def self.up
    create_table :demo_responses do |t|
      t.integer :user_id
      t.integer :demo_answer_id

      t.timestamps
    end

    add_index :demo_responses, :user_id
    add_index :demo_responses, :demo_answer_id
  end

  def self.down
    drop_table :demo_responses
  end
end

class CreateDemoAnswers < ActiveRecord::Migration
  def self.up
    create_table :demo_answers do |t|
      t.string :text
      t.integer :position
      t.integer :demo_question_id

      t.timestamps
    end
    add_index :demo_answers, :demo_question_id
  end

  def self.down
    drop_table :demo_answers
  end
end

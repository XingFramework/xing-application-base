class CreateScreenerQuestions < ActiveRecord::Migration
  def self.up
    create_table :screener_questions do |t|
      t.text :text
      t.text :options
      t.integer :study_id

      t.timestamps
    end
    
    add_index :screener_questions, :study_id
  end

  def self.down
    drop_table :screener_questions
  end
end

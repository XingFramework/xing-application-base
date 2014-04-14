class CreateScreenerAnswers < ActiveRecord::Migration
  def self.up
    create_table :screener_answers do |t|
      t.text :text
      t.integer :study_application_id
      t.integer :screener_question_id
      
      t.integer :rating

      t.timestamps
    end
    
    add_index :screener_answers, [:study_application_id, :screener_question_id], { :name => "index_screen_answers_on_application_id_and_screen_question_id" }
  end

  def self.down
    drop_table :screener_answers
  end
end

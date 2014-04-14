class CreateStudyAnswers < ActiveRecord::Migration
  def self.up
    create_table :study_answers do |t|
      t.integer :study_question_id
      t.integer :study_application_id

      t.timestamps
    end
    
    add_index :study_answers, [:study_question_id, :study_application_id], { :name => "index_study_answers_on_application_id_and_study_question_id" }
  end

  def self.down
    drop_table :study_answers
  end
end

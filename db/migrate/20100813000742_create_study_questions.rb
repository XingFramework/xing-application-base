class CreateStudyQuestions < ActiveRecord::Migration
  def self.up
    create_table :study_questions do |t|
      t.text :text
      t.integer :study_id
      
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at

      t.text :embed

      t.timestamps
    end
    
    add_index :study_questions, :study_id
  end

  def self.down
    drop_table :study_questions
  end
end

class CreateDemoQuestions < ActiveRecord::Migration
  def self.up
    create_table :demo_questions do |t|
      t.string :text
      t.string :caption
      t.integer :position
      t.boolean :multiple, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :demo_questions
  end
end

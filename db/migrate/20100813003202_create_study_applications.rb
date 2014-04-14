class CreateStudyApplications < ActiveRecord::Migration
  def self.up
    create_table :study_applications do |t|
      t.integer :study_id
      t.integer :consumer_id

      # for consumer segmenting within study
      t.integer :segment_id
      
      # for email invites
      t.boolean :invite, :default => false
      t.string :email
      
      # states
      t.integer :status, :default => 0
      
      t.datetime :accepted_or_declined_at
      t.datetime :started_at
      t.datetime :completed_at
      t.datetime :payed_at
      t.datetime :disputed_at
      
      t.text :dispute_reason

      t.timestamps
    end
    
    add_index :study_applications, [:study_id, :consumer_id]
    add_index :study_applications, :segment_id
  end

  def self.down
    drop_table :study_applications
  end
end

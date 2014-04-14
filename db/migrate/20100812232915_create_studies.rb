class CreateStudies < ActiveRecord::Migration
  def self.up
    create_table :studies do |t|
      t.string :title
      t.text :notes
      
      t.integer :quota

      t.integer :duration
      
      t.datetime :start_at
      t.datetime :end_at
      
      t.boolean :gender_m
      t.boolean :gender_f
      
      t.integer :age_from
      t.integer :age_to
      
      t.integer :researcher_id

      t.timestamps
    end
    
    add_index :studies, :researcher_id
  end

  def self.down
    drop_table :studies
  end
end

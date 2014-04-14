class CreateSegments < ActiveRecord::Migration
  def self.up
    create_table :segments do |t|
      t.string :name
      t.integer :study_id

      t.timestamps
    end
    add_index :segments, :study_id
  end

  def self.down
    drop_table :segments
  end
end

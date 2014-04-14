class CreateSynonyms < ActiveRecord::Migration
  def self.up
    create_table :synonyms do |t|
      t.string :name
      t.integer :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :synonyms
  end
end

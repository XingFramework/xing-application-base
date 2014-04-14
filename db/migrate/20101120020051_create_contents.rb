class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.string :name
      t.string :group
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end

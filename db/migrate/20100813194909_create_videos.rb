class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.integer  "owner_id"
      t.string   "owner_type"
      
      t.integer :status, :default => 0

      t.string   "camatar_flv_url"
      t.string   "camatar_image_url"
      t.string   "camatar_thumb_url"
      t.string   "camatar_token"
      t.integer  "camatar_duration"
      t.integer  "camatar_max_duration"
      t.string   "token"
      t.string   "transcoded_url"
      t.datetime "transcoded_at"

      t.timestamps
    end
    
    add_index :videos, [:owner_id, :owner_type]
  end

  def self.down
    drop_table :videos
  end
end

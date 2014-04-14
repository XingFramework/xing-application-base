class AddUploadDurationToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :upload_duration, :integer
  end

  def self.down
    remove_column :videos, :upload_duration
  end
end

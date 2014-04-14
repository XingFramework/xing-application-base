class AddFilenameToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :filename, :string
  end

  def self.down
    remove_column :videos, :filename
  end
end

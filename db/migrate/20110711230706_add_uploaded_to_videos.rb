class AddUploadedToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :uploaded_filename, :string
  end

  def self.down
    remove_column :videos, :uploaded_filename
  end
end

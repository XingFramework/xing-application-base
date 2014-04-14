class AddZencoderJobIdtoVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :zencoder_job_id, :string
    add_column :videos, :zencoder_finished_at, :datetime
  end

  def self.down
    remove_column :videos, :zencoder_job_id
    remove_column :videos, :zencoder_finished_at, :datetime
  end
end

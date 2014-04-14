class AddTranscriptionsToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :transcript_upload_url, :string
    add_column :videos, :transcript_record_id, :string
    add_column :videos, :transcript_text, :text
    add_column :videos, :custom_text, :text
  end

  def self.down
    remove_column :videos, :custom_text
    remove_column :videos, :transcript_text
    remove_column :videos, :transcript_record_id
    remove_column :videos, :transcript_upload_url
  end
end

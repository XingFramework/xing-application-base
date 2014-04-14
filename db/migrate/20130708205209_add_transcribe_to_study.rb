class AddTranscribeToStudy < ActiveRecord::Migration
  def self.up
    add_column :studies, :transcribe, :boolean, :default => true
  end

  def self.down
    remove_column :studies, :transcribe
  end
end

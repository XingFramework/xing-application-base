class AddNotifiedFullAtToStudyApplications < ActiveRecord::Migration
  def self.up
    add_column :study_applications, :notified_full_at, :datetime
  end

  def self.down
    remove_column :study_applications, :notified_full_at
  end
end

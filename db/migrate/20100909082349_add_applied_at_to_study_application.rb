class AddAppliedAtToStudyApplication < ActiveRecord::Migration
  def self.up
    add_column :study_applications, :applied_at, :datetime
  end

  def self.down
    remove_column :study_applications, :applied_at
  end
end

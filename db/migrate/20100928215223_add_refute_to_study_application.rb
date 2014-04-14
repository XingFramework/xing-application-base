class AddRefuteToStudyApplication < ActiveRecord::Migration
  def self.up
    add_column :study_applications, :refute_reason, :string
    add_column :study_applications, :refuted_at, :datetime
  end

  def self.down
    remove_column :study_applications, :refuted_at
    remove_column :study_applications, :refute_reason
  end
end

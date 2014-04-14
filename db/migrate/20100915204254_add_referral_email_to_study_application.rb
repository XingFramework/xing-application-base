class AddReferralEmailToStudyApplication < ActiveRecord::Migration
  def self.up
    add_column :study_applications, :referral_email, :string
  end

  def self.down
    remove_column :study_applications, :referral_email
  end
end

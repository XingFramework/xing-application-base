class AddReferralEmailAndTokenToStudyApplication < ActiveRecord::Migration
  def self.up
    add_column :study_applications, :referral_email, :string
    add_column :study_applications, :token, :string
  end

  def self.down
    remove_column :study_applications, :token
    remove_column :study_applications, :referral_email
  end
end

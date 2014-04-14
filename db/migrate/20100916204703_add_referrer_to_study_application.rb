class AddReferrerToStudyApplication < ActiveRecord::Migration
  def self.up
    remove_column :study_applications, :referral_email
    add_column :study_applications, :referrer_id, :integer    
  end

  def self.down
    add_column :study_applications, :referral_email, :string
    remove_column :study_applications, :referrer_id    
  end
end

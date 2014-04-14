class AddInviterToStudyApplication < ActiveRecord::Migration
  def self.up
    remove_column :study_applications, :invite
    remove_column :study_applications, :email
    
    add_column :study_applications, :inviter_id, :integer, :default => nil
  end

  def self.down
    remove_column :study_applications, :inviter_id    
    
    add_column :study_applications, :invite, :boolean, :default => false
    add_column :study_applications, :email, :string        
  end
end

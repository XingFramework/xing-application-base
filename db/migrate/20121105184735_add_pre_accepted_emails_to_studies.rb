class AddPreAcceptedEmailsToStudies < ActiveRecord::Migration
  def self.up
    add_column :studies, :pre_accepted_emails, :text
  end

  def self.down
    remove_column :studies, :pre_accepted_emails
  end
end

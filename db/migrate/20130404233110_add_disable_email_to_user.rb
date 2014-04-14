class AddDisableEmailToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :disable_email, :boolean

    
    # Consumer.all.each do |c|
    #   #// update mailer settings as needed
    #   if [nil, Consumer::MAILER_SETTING_NEVER, Consumer::MAILER_SETTING_IMMEDIATELY, Consumer::MAILER_SETTING_WEEKLY].include? c.mailer_setting 
    #     #// do nothing
    #   else
    #     c.mailer_setting = Consumer::MAILER_SETTING_WEEKLY
    #   end

    #   #// disabled emails if old user that has not loggedin in a while
    #   # if c.last_login_at.blank? || c.last_login_at < 6.months.ago
    #   # c.disable_email = true
    #   # end

    #   c.save( false ) if c.changed?
    # end

    #// update mailer settings    
    Consumer.where("mailer_setting IS NOT NULL AND mailer_setting NOT IN (?)", [Consumer::MAILER_SETTING_NEVER, Consumer::MAILER_SETTING_IMMEDIATELY, Consumer::MAILER_SETTING_WEEKLY]).update_all :mailer_setting => Consumer::MAILER_SETTING_WEEKLY

    #// disable emails for inactive consumers
    Consumer.where("id NOT IN (?)", Consumer.not_internal_account.not_blacklisted.joins(:study_applications).where("last_login_at > ? OR study_applications.status in (5,6)", (Date.today - 6.months)).order(:id).uniq.map(&:id)).update_all :disable_email => true
  end

  def self.down
    remove_column :users, :disable_email
  end
end

byebug
FROM_ADDRESS     = Rails.application.secrets.emails['from']
REPLY_TO_ADDRESS = Rails.application.secrets.emails['reply_to'] ||
                     Rails.application.secrets.emails['from']

ActionMailer::Base.smtp_settings = {
  :address              => Rails.application.secrets.smtp['address'],
  :port                 => Rails.application.secrets.smtp['port'],
  :domain               => Rails.application.secrets.smtp['domain'],
  :user_name            => Rails.application.secrets.smtp['user_name'],
  :password             => Rails.application.secrets.smtp['password'],
  :authentication       => :plain,
  :raise_delivery_errors => (Rails.env.development?),
  :enable_starttls_auto => true
}


class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to      = Rails.application.secrets.emails['test'] rescue "test@lrdesign.com"
  end
end

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?

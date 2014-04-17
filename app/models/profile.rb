require 'class_registry'
module Profile
  include ClassRegistry
  def self.registrar; Profile; end

  def self.for(user)  # profile version
    self.registry[user.role_name].where(:user_id => user.id).first
  end

  def self.users
    User.where(:role_name => self.registry_key)
  end


  Dir[File.dirname(__FILE__) + '/profile/*.rb'].each { |file| require file }

end

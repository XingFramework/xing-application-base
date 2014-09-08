# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
ActiveSupport::Deprecation.debug = true

RSpec.configure do |config|
  config.mock_with :rspec

  config.include Devise::TestHelpers, :type => :controller
  config.include Devise::TestHelpers, :type => :helper
  config.include RequestAuthentication, :type => :request
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  DatabaseCleaner.strategy = :transaction

  config.before :suite do
    File::open("log/test.log", "w") do |log|
      log.write ""
    end
  end


  config.before :all, :type => [ :view ] do
    pending "Pending removal.  Back-end does not use views."
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
    load 'db/seeds.rb'
  end

end

def content_for(name)
  view.instance_variable_get("@content_for_#{name}")
end

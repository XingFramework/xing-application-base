# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
require 'waterpig'
require 'capybara/email/rspec'
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}


ActiveSupport::Deprecation.debug = true

TEST_PASSWORD = 'password'
TEST_IMAGE = File.join(Rails.root, '/spec/fixtures/test_image.png')

RSpec.configure do |config|
  config.mock_with :rspec

  config.include Features::SessionHelpers, type: :feature

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

  config.before :each, :type => :controller do
    @request.env['HTTP_ACCEPT'] = 'application/json'
    @request.host = "api.example.com"
  end

  config.before :each, :type => :request do
    host! "api.example.com"
  end

  config.before :each, :type => :request, :frontend => true do
    host! "www.example.com"
  end

  config.waterpig_truncation_types = [:feature, :task]
end

def content_for(name)
  view.instance_variable_get("@content_for_#{name}")
end

def routes
  Rails.application.routes.url_helpers
end

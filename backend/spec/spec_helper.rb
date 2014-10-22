# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
ActiveSupport::Deprecation.debug = true

include BrowserTools
TEST_PASSWORD = 'password'
TEST_IMAGE = File.join(Rails.root, '/spec/fixtures/test_image.png')

RSpec.configure do |config|
  config.mock_with :rspec

  config.include Devise::TestHelpers, :type => :controller
  config.include Devise::TestHelpers, :type => :helper
  config.include Features::SessionHelpers, type: :feature

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  DatabaseCleaner.strategy = :transaction

  # setup VCR to record all external requests with a single casette
  config.around :each
    VCR.use_cassette("default_vcr_cassette") { example.call }
  end

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
  end

  truncation_types = [:feature, :task]

  config.before :each, :type => proc{ |value| truncation_types.include?(value)} do
    Rails.application.config.action_dispatch.show_exceptions = true
    DatabaseCleaner.clean_with :truncation, {:except => %w[spatial_ref_sys]}
    load 'db/seeds.rb'
  end

  config.after :each, :type => proc{ |value| truncation_types.include?(value)} do
    DatabaseCleaner.clean_with :truncation, {:except => %w[spatial_ref_sys]}
    load 'db/seeds.rb'
  end

  config.before :each, :type => proc{ |value| not truncation_types.include?(value)} do
    DatabaseCleaner.start
  end

  config.after :each, :type => proc{ |value| not truncation_types.include?(value)} do
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

def routes
  Rails.application.routes.url_helpers
end

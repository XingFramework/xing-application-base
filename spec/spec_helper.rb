# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../backend/config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
require 'waterpig'
require 'capybara/email/rspec'
require 'sidekiq/testing'
require 'xing/rspec-features'

Dir[File.join(File.dirname(__FILE__), "../backend/app/models/*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f}

ActiveSupport::Deprecation.debug = true

TEST_PASSWORD = 'password'
TEST_IMAGE = File.join(Rails.root, '/spec/fixtures/test_image.png')


RSpec.configure do |config|
  config.mock_with :rspec

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.waterpig_log_browser_console = true
  config.waterpig_db_seeds = 'backend/db/seeds.rb'

  config.waterpig_browser_sizes = {
    :mobile  => { :width => 348, :height => 480 },
    :small   => { :width => 550, :height => 700 },
    :medium  => { :width => 800, :height => 900 },
    :desktop => { :width => 1024, :height => 1024 }
  }

  DatabaseCleaner.strategy = :transaction

  config.before :each, :type => :request do
    host! "api.example.com"
  end

  config.before :each, :type => :request, :frontend => true do
    host! "www.example.com"
  end

  config.waterpig_truncation_types = [:feature, :task]
end

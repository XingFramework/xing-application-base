# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

XING_ROOT  = File.expand_path('../../../', __FILE__)
RAILS_ROOT = File.join(XING_ROOT, 'backend')

require File.join(XING_ROOT, 'backend', 'config', 'environment')
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
require 'waterpig'
require 'capybara'
require 'capybara/email/rspec'
require 'sidekiq/testing'
require 'rspec-steps/monkeypatching'

Dir[File.join(XING_ROOT, 'e2e_tests', 'support/**/*.rb')].each {|f| puts "requiring #{f}"; require f unless f == __FILE__}


ActiveSupport::Deprecation.debug = true

TEST_PASSWORD = 'password'
TEST_IMAGE = File.join(Rails.root, '/spec/fixtures/test_image.png')


RSpec.configure do |config|
  config.mock_with :rspec

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.waterpig_log_browser_console = true
  config.waterpig_db_seeds = RAILS_ROOT + '/db/seeds.rb'
  config.waterpig_snapshot_dir = XING_ROOT + 'e2e_tests/snapshots'

  config.waterpig_browser_sizes = {
    :mobile  => { :width => 348, :height => 480 },
    :small   => { :width => 550, :height => 700 },
    :medium  => { :width => 800, :height => 900 },
    :desktop => { :width => 1024, :height => 1024 }
  }

  DatabaseCleaner.strategy = :transaction

  config.waterpig_truncation_types = [:feature]
end

def routes
  Rails.application.routes.url_helpers
end

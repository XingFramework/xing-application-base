require 'waterpig/deadbeat-connections'

Rails.application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = false
  config.eager_load = false


  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Render exception templates instead of raising them -
  #   The downside of this is that e.g. request specs won't raise exceptions in
  #   test mode (which may lead to false-passes if the contents aren't
  #   inspected well enough) but in feature tests we get random false-fails
  #   because front end requests are still processing when the test is closing
  #   down - so e.g. we get missing DB resources because the database has been
  #   truncated.
  #
  #   One solution would be a middleware that sees a request with e.g. a
  #   special header and disables exception raising. Another would be to use a
  #   signal akin to the Brownie "page ready for rendering" to say "okay, we
  #   can be done with the tests now."
  config.action_dispatch.show_exceptions = true

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  config.middleware.insert_before ActiveRecord::ConnectionAdapters::ConnectionManagement, Waterpig::DeadbeatConnectionRelease
  config.middleware.use LogJsonResponses
  config.middleware.use LogJsonRequests
end

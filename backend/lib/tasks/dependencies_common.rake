require 'tasks/secrets_validator'
require 'tasks/database_config_validator'

namespace :dependencies do
  include DependencyUtils

  task :check => [
    :secrets,
    :database_config,
    'redis:running'
  ]

  task :secrets do
    SecretsValidator.new.assert_existence
    env = ENV['RAILS_ENV'] || 'development'
    validator = SecretsValidator.new
    validator.validate(env)
    validator.report!
  end
  task :database_config do
    DatabaseConfigValidator.new.assert_existence
    env = ENV['RAILS_ENV'] || 'development'
    validator = DatabaseConfigValidator.new
    validator.validate(env)
    validator.report!
  end

  task :api_host do
    # TODO - if in development, check that the API host resolves
  end

  namespace :redis do
    task :running => :installed do
    end
    task :installed do
      sh_or_fail "which redis-cli", "Redis is not running."
    end
  end
end


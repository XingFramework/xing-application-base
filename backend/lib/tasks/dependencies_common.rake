require 'tasks/secrets_validator'

namespace :dependencies do
  include DependencyUtils

  task :development => [
    'secrets:development',
    #:api_host,
    'redis:running'
  ]

  namespace :secrets do
    task :existence do
      SecretsValidator.assert_existence
    end
    task :values => :existence do
      env = ENV['RAILS_ENV'] || 'development'
      validator = SecretsValidator.new
      validator.validate(env)
      validator.report!
    end
  end
  task :secrets => 'secrets:values'

  task :api_host do
  end

  namespace :redis do
    task :running => :installed do
    end
    task :installed do
      sh_or_fail "which redis-cli", "Redis is not running."
    end
  end
end


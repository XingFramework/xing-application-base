source "https://rubygems.org"

eval_gemfile File.expand_path('../backend/Gemfile', __FILE__)

gem "capistrano"
gem 'rack'
gem 'compass'
gem 'capistrano-passenger'

# To support integration tests
group :test do
  gem 'rspec-steps'
  gem 'waterpig', ">= 0.6.1"
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'capybara-email'
  gem 'database_cleaner'
  gem 'simplecov'  
end


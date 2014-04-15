source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.4'
# Use SCSS for stylesheets
gem 'sass-rails'
gem 'haml-rails'
gem 'uglifier'
gem 'pg'
gem 'activerecord-postgis-adapter'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

gem 'devise'

# gem 'debugger', group: [:development, :test]
group :development, :test do
  gem "rspec", ">= 2.1.0"
  gem "rspec-rails", ">= 2.1.0"
  gem "factory_girl_rails"
  gem 'annotate'
  gem 'simplecov'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'rspec-steps', ">= 0.0.6"
  gem 'byebug'
  gem 'quiet_assets'
  #gem 'shoulda'
  gem 'vcr'
  gem 'capybara-email'
  #gem 'cadre'
  gem 'timecop'

end

group :test do
  gem 'webmock'
end

group :development do
  gem 'capistrano', "< 3.0" #maybe more properly in a "deploy" group...
  gem 'capistrano-ext'

  gem "pivotal-github"
  gem 'sass-rails-source-maps', :git => "git@github.com:LRDesign/sass-rails-source-maps.git"
end

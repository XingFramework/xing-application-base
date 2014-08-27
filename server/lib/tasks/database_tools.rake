namespace :db do
  #Change this to raise once full_recycle shouldn't work
  task :only_if_undeployed

  desc "Rebuild the database from scratch, useful when editing migrations"
  task :recycle => [
    :only_if_undeployed,
    "install",
    "test:prepare",
  ]

  namespace :test do 
    task :prepare do
      old_env = Rails.env
      Rails.env = "test"
      ENV['RAILS_ENV'] = "test"
      Rake::Task['db:load_config'].reenable
      Rake::Task['db:seed'].reenable
      Rake::Task['db:seed'].invoke
    end
  end

  desc "Build and seed the database for a new install"
  task :install => [
    :environment,
    "migrate:reset",
    "seed",
    # "initial_data:populate"
    ]
end

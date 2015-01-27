namespace :backend do
  task :bundle_install do
    # this is a standard bundle install -- we may need to do some configs
    # on next deploy to capistrano to copy in a bundler config file so
    # it uses --deployment
    Bundler.with_clean_env do
      Dir.chdir("backend"){ sh *%w{bundle install} }
    end
  end

  task :require_tmux do
    sh 'which tmux'
  end

  task :check_dependencies => %w{bundle_install require_tmux} do
    Bundler.with_clean_env do
      Dir.chdir("backend") do
        if ENV['DEPENDENCIES_INCLUDE_TMUX']
          sh "bundle exec rake dependencies:check:tmux"
        else
          sh "bundle exec rake dependencies:check"
        end
      end
    end
  end

  desc "Migrate database up to current"
  task :db_migrate => :bundle_install do
    Bundler.with_clean_env do
      Dir.chdir("backend"){ sh *%w{bundle exec rake db:migrate} }
    end
  end
  task :setup => [:bundle_install, :db_migrate]

  task :db_seed => :db_migrate do
    Bundler.with_clean_env do
      Dir.chdir("backend"){ sh *%w{bundle exec rake db:seed} }
    end
  end

  desc "Precompile rails assets"
  task :assets_precompile => [:bundle_install, :db_migrate] do
    Bundler.with_clean_env do
      Dir.chdir("backend"){ sh *%w{bundle exec rake assets:precompile}}
    end
  end

  task :all => [:db_seed, :assets_precompile]
end
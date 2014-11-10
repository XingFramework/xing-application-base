# config valid only for Capistrano 3.1
lock '3.2.1'

set :repo_url, 'git@git.lrdesign.com:lrd/cms2.git'
set :pty, true

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

set :linked_files, %w{
  backend/config/database.yml
  backend/config/secrets.yml
  backend/public/sitemap.xml
}
set :linked_dirs, %w{
  frontend/node_modules
  backend/log
  backend/tmp/pids
  backend/tmp/cache
  backend/tmp/sockets
  backend/vendor/bundle
  backend/public/system
}

# These files and directories must be writeable by user 'apache'
# or deploy is not considered successful
set :required_writeable_files, %w{
  backend/log
  backend/tmp/pids
  backend/tmp/cache
  backend/public/system
  backend/public/sitemap.xml
}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :backend_path, proc{ File::join(release_path, "backend") }
set :webserver_group, "web"
set :webserver_user, "web"

namespace :deploy do
  desc 'Build app'
  task :build do
    on roles(:app), :in => :parallel do
      within release_path do
        with :rails_env => fetch(:stage) do
          rake "build"
        end
      end
    end
  end
  after 'symlink:shared', :build

  task :bundle_config do
    on roles(:app), :in => :parallel do
      execute "mkdir -p #{fetch(:backend_path)}/.bundle"
      bundle_config = StringIO.new(<<-EOC)
---
BUNDLE_FROZEN: '1'
BUNDLE_PATH: "#{File::join(shared_path, "backend/vendor/bundle")}"
BUNDLE_DISABLE_SHARED_GEMS: '1'
      EOC
      upload! bundle_config, "#{fetch(:backend_path)}/.bundle/config"
    end
  end
  before :build, :bundle_config

  task :perms do
    on roles(:app), :in => :parallel do
      within File::join(release_path, "backend") do
        as(:root) do
          execute "chgrp", fetch(:webserver_group),  "-RL", ".bundle"
          execute "chmod", "g+wX", "-R", ".bundle"
          execute "chown", fetch(:webserver_user), ".bundle/config"
          execute "chgrp", fetch(:webserver_group),  "-RL", "public"
          execute "chmod", "g+wX", "-R", "public"
          execute "chgrp", fetch(:webserver_group),  "-RL", "tmp"
          execute "chmod", "g+wX", "-R", "tmp"
          execute "chgrp", fetch(:webserver_group),  "-RL", "log"
          execute "chmod", "g+wX", "-R", "log"
        end
      end
    end
  end
  after 'symlink:shared', :perms

  task :confirm_writeable_files do
    on roles(:app), :in => :parallel do
      fetch(:required_writeable_files).each do |filename|
        can_write = capture("sudo -u apache test -w #{File::join(release_path, filename)} && echo yes || echo no")
        unless can_write == "yes"
          error "Test for writeability failed. User 'apache' cannot write #{filename}."
          exit 1  #TODO: prevent this from printing a stack trace, if possible.
        end
      end
    end
  end
  after 'symlink:shared', :confirm_writeable_files

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within fetch(:backend_path) do
        execute :touch, 'tmp/restart.txt'
      end
    end
  end

  desc "Preload the rails app"
  task :warm_up_rails do
    if url = fetch(:rails_warmup_url)
      puts "Attempting to warm up the rails app."
      sh "curl -H \"Accept: application/json\" #{url} > /dev/null"
    end
  end


  after :publishing, :restart
  after :publishing, :warm_up_rails

#  after :restart, :clear_cache do
#    on roles(:web), in: :groups, limit: 3, wait: 10 do
#      # Here we can do anything such as:
#      within fetch(:backend_path) do
#        with :rails_env => fetch(:stage) do
#          execute :bundle, 'exec', 'rake', 'cache:clear'
#        end
#      end
#    end
#  end
end

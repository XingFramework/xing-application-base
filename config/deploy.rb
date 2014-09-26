# config valid only for Capistrano 3.1
lock '3.2.1'

set :repo_url, 'git@git.lrdesign.com:lrd/uccf-website.git'

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

set :linked_files, %w{backend/config/database.yml backend/config/secrets.yml}
set :linked_dirs, %w{
  frontend/node_modules
  backend/log backend/tmp/pids backend/tmp/cache backend/tmp/sockets backend/vendor/bundle backend/public/system
}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :backend_path, proc{ File::join(release_path, "backend") }

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

  task :perms do
    on roles(:app), :in => :parallel do
      within File::join(release_path, "backend") do
        execute "chown", "apache:apache", "-R", "public"
      end
    end
  end
  after 'symlink:shared', :perms

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within fetch(:backend_path) do
        execute :touch, 'tmp/restart.txt'
      end
    end
  end

  after :publishing, :restart

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

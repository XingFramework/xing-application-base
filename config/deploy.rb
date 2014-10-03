# config valid only for Capistrano 3.1
lock '3.2.1'

set :repo_url, 'git@git.lrdesign.com:lrd/uccf-website.git'
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
        execute "chgrp", "web",  "-RL", "public"
        execute "chmod", "g+wX", "-R", "public"
        execute "chgrp", "web",  "-RL", "tmp"
        execute "chmod", "g+wX", "-R", "tmp"
        execute "chgrp", "web",  "-RL", "log"
        execute "chmod", "g+wX", "-R", "log"
      end
    end
  end
  after 'symlink:shared', :perms

#  task :confirm_writeable_files do
#    on roles(:app), :in => :parallel do
#      within File::join(release_path) do
#        fetch(:required_writeable_files).each do |filename|
#            begin
#              puts "Testing writeability of #{filename}"
#              as(:apache){ execute "test -w #{filename}" }
#              as(:apache){ execute "pwd" }
#              as(:apache){ execute "ls -l #{filename}" }
#            rescue Object #SSHKit::Runner::ExecuteError
#              error "Test for writeability failed. User 'apache' cannot write #{filename}."
#              raise
#              exit 1  #TODO: prevent this from printing a stack trace, if possible.
#            end
#        end
#      end
#    end
#  end
#  after 'symlink:shared', :confirm_writeable_files

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

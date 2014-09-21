require 'bundler'

desc "The whole shebang"
task :build => 'build:all'

desc "Run rails server and grunt watch to start a dev environment"
task :develop => 'develop:all'

namespace :client do
  task :npm_install do
    Dir.chdir("client"){ sh *%w{npm install} }
  end

  task :bundle_install do
    Dir.chdir("client"){ sh *%w{bundle install} }
  end

  task :setup => [:npm_install, :bundle_install]
end

namespace :develop do
  child_pids = []

  task :launch_browser do
    fork do
      require 'net/http'
      require 'json'

      server_port = 35729
      setup_time_limit = 60
      begin_time = Time.now
      begin
        test_conn =  TCPSocket.new 'localhost', server_port
      rescue Errno::ECONNREFUSED
        if Time.now - begin_time > setup_time_limit
          raise "Couldn't connect to test server after #{setup_time_limit} seconds - bailing out"
        else
          sleep 0.05
          retry
        end
      ensure
        test_conn.close rescue nil
      end

      changes = JSON.parse(Net::HTTP.get(URI("http://localhost:#{server_port}/changes")))
      if changes["clients"].empty?
        sh *%w{open http://localhost:3000/}
      end
    end
  end

  task :grunt_watch => 'client:setup' do
    child_pid = Process.fork do
      Dir.chdir("client"){
        sh *%w{bundle exec node_modules/.bin/grunt watch:develop}
      }
    end
    puts "Grunt running in pid #{child_pid}"
    child_pids << child_pid
  end

  namespace :server do
    task :bundle_install do
      Bundler.with_clean_env do
        Dir.chdir("server"){ sh *%w{bundle install} }
      end
    end
    task :setup => [:bundle_install]
  end

  task :rails_server => [:links, 'server:setup'] do
    child_pid = Process.fork do
      Dir.chdir("server"){
        sh *%w{bundle exec rails server}
      }
    end
    puts "Rails running in pid #{child_pid}"
    child_pids << child_pid
  end

  task :all => [:grunt_watch, :rails_server] do
    Process.waitall
  end

  task :links do
    %w{index.html assets fonts}.each do |thing|
      sh "ln", "-sfn", "../../client/bin/#{thing}", "server/public/#{thing}"
    end
  end
  task :all => [:links]
end

namespace :build do
  task :all => %w{client:all server:all}

  namespace :client do
    task :npm_install do
      desc "Compile the client app into client/bin"
      task :grunt_compile => [:npm_install, :bundle_install] do
        Dir.chdir("client"){ sh *%w{bundle exec node_modules/.bin/grunt compile} }
      end

      task :all => [:npm_install, :grunt_compile]
    end
  end

  task :client_to_assets do
    sh *%w{cp -a client/bin/* server/public/}
  end


  namespace :server do
    task :bundle_install do
      Bundler.with_clean_env do
        Dir.chdir("server"){ sh *%w{bundle install --deployment} }
      end
    end
    task :setup => [:bundle_install]

    desc "Migrate database up to current"
    task :db_migrate => :bundle_install do
      Bundler.with_clean_env do
        Dir.chdir("server"){ sh *%w{bundle exec rake db:migrate db:seed} }
      end
    end

    desc "Precompile rails assets"
    task :assets_precompile => [:bundle_install, :db_migrate] do
      Bundler.with_clean_env do
        Dir.chdir("server"){ sh *%w{bundle exec rake assets:precompile}}
      end
    end

    task :all => [:db_migrate, :assets_precompile]
  end

  task 'server:assets_precompile' => :client_to_assets
end

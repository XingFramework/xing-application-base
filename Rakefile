require 'bundler'

desc "The whole shebang"
task :build => 'build:all'

desc "Run rails server and grunt watch to start a dev environment"
task :develop => 'develop:all'

desc "Run Rspec tests"
task :spec => "spec:fast"

namespace :frontend do
  task :npm_install do
    Dir.chdir("frontend"){ sh *%w{npm install} }
  end

  task :bundle_install do
    Dir.chdir("frontend"){ sh *%w{bundle install} }
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

      sleep 3 #It's possible the existing browser just hasn't connected to the new LR yet

      changes = JSON.parse(Net::HTTP.get(URI("http://localhost:#{server_port}/changed")))
      if changes["clients"].empty?
        puts "No running development browsers: launching...."

        cmds = %w{open xdg-open chrome chromium}
        cmd = nil
        begin
          cmd = cmds.shift
          sh "which", cmd
        rescue
          if cmds.empty?
            warn "Can't find any executable to launch a browser with. (WTF?) --jdl"
          else
            retry
          end
        end

        sh cmd, "http://localhost:3000/"
      else
        puts "There's already a browser attached to the LiveReload server."
        p changes["clients"].first
      end
    end
  end

  task :grunt_watch => 'frontend:setup' do
    child_pid = Process.fork do
      Dir.chdir("frontend"){
        sh *%w{bundle exec node_modules/.bin/grunt watch:develop}
      }
    end
    puts "Grunt running in pid #{child_pid}"
    child_pids << child_pid
  end

  namespace :backend do
    task :bundle_install do
      Bundler.with_clean_env do
        Dir.chdir("backend"){ sh *%w{bundle install} }
      end
    end
    task :setup => [:bundle_install]
  end

  task :rails_server => [:links, 'backend:setup'] do
    child_pid = Process.fork do
      Dir.chdir("backend"){
        sh *%w{bundle exec rails server}
      }
    end
    puts "Rails running in pid #{child_pid}"
    child_pids << child_pid
  end

  task :all => [:grunt_watch, :rails_server, :launch_browser] do
    Process.waitall
  end

  task :links do
    %w{index.html assets fonts}.each do |thing|
      sh "ln", "-sfn", "../../frontend/bin/#{thing}", "backend/public/#{thing}"
    end
  end
  task :all => [:links]
end

namespace :spec do

  task :grunt_develop => 'frontend:setup' do
    Dir.chdir("frontend"){
      sh *%w{bundle exec node_modules/.bin/grunt develop}
    }
  end

  namespace :backend do
    task :bundle_install do
      Bundler.with_clean_env do
        Dir.chdir("backend"){ sh *%w{bundle install} }
      end
    end
    task :setup => [:bundle_install]
  end


  task :links do
    %w{index.html assets fonts}.each do |thing|
      sh "ln", "-sfn", "../../frontend/bin/#{thing}", "backend/public/#{thing}"
    end
  end

  task :full, [:spec_files] => [:grunt_develop, :links, 'backend:setup'] do |t, args|
    Dir.chdir("backend"){
      commands = %w{bundle exec rspec}
      if args[:spec_files]
        commands.push(args[:spec_files])
      end
      sh *commands
    }
  end

  task :fast, [:spec_files] => [:links, 'backend:setup'] do |t, args|
    Dir.chdir("backend"){
      commands = %w{bundle exec rspec}
      if args[:spec_files]
        commands.push(args[:spec_files])
      else
        commands.push("--tag").push("~type:feature")
      end
      sh *commands
    }
  end
end

namespace :build do
  task :all => %w{frontend:all backend:all}

  namespace :frontend do
    task :npm_install do
      desc "Compile the frontend app into frontend/bin"
      task :grunt_compile => [:npm_install, :bundle_install] do
        Dir.chdir("frontend"){ sh *%w{bundle exec node_modules/.bin/grunt compile} }
      end

      task :all => [:npm_install, :grunt_compile]
    end
  end

  task :frontend_to_assets do
    sh *%w{cp -a frontend/bin/* backend/public/}
  end


  namespace :backend do
    task :bundle_install do
      Bundler.with_clean_env do
        Dir.chdir("backend"){ sh *%w{bundle install --deployment} }
      end
    end
    task :setup => [:bundle_install]

    desc "Migrate database up to current"
    task :db_migrate => :bundle_install do
      Bundler.with_clean_env do
        Dir.chdir("backend"){ sh *%w{bundle exec rake db:migrate db:seed} }
      end
    end

    desc "Precompile rails assets"
    task :assets_precompile => [:bundle_install, :db_migrate] do
      Bundler.with_clean_env do
        Dir.chdir("backend"){ sh *%w{bundle exec rake assets:precompile}}
      end
    end

    task :all => [:db_migrate, :assets_precompile]
  end

  task 'backend:assets_precompile' => :frontend_to_assets
end

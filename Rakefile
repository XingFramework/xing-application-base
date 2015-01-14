require 'bundler'

class ChildManager
  def initialize
    @child_pids = []
    @parent_pid = Process.pid
    @child_data = {}
  end
  attr_accessor :child_pids, :child_data

  ChildRecord = Struct.new(:name, :status)

  def start_child(name, dir, &block)
    child_pid = Process.fork do
      Signal.trap("HUP") do
        puts "Parent exited"
        exit
      end

      Bundler.with_clean_env do
        Dir.chdir(dir, &block)
      end
    end
    puts "#{@parent_pid}: #{name} running in pid #{child_pid}"

    at_exit { kill_child(child_pid) }
    child_data[child_pid] = ChildRecord.new(name, nil)
    child_pids << child_pid
  end

  def exited?(pid)
    return false unless child_data.has_key?(pid)
    return true unless child_data[pid].status.nil?

    begin
      _apid, status = *Process.wait2(pid, Process::WNOHANG | Process::WUNTRACED)
    rescue Errno::ECHILD
      return false
    end

    unless status.nil?
      child_data[pid].status = status
      return true
    end
    return false
  end

  def wait_until_dead(pilimit)
    start = Time.now
    while Time.now - start < limit
      Process.waitpid(-1, Process::WNOHANG | Process::WUNTRACED)
      sleep(0.1)
    end
    return false
  rescue SystemCallError # = no children
    return true
  end

  def kill_child(pid)
    unless Process.pid == @parent_pid
      puts "#{Process.pid} #@parent_pid Not original parent: not killing"
      return
    end
    puts "PID #{Process.pid} is killing child #{pid} #{child_data[pid].name}"

    if exited?(pid)
      puts "#{pid} #{child_data[pid].name} already exited"
      return
    end

    begin
      Process::kill("TERM", pid)
    rescue Errno::ESRCH
      puts "Hm. #{pid} is already gone: dead?"
      return
    end

    limit = 10
    start = Time.now
    while Time.now - start < limit
      begin
        Process::kill(0, pid)
        sleep(0.1)
      rescue Errno::ESRCH
        return
      end
    end

    begin
      Process::kill("KILL", pid)
    rescue Errno::ESRCH
      return
    end
  end

  def kill_all
    unless Process.pid == @parent_pid
      puts "Although #{Process.pid} was asked to kill all, it isn't #@parent_pid the original parent"
      return
    end
    child_pids.each do |pid|
      kill_child(pid)
    end
    previous_term_trap = trap "TERM" do
      p "Trapped TERM once"
      trap "TERM", previous_term_trap
    end
    p previous_term_trap
    Process::kill("TERM", 0)
    p Process.waitall rescue []
    p @child_data
  end
end

desc "The whole shebang"
task :build => [:check_dependencies, 'build:all']

desc "Run rails server and grunt watch to start a dev environment"
task :develop => [:check_dependencies,'develop:all']

desc "Confirm that the app is in a state to run"
task :preflight => %w{check_dependencies develop:links}

desc "Run Rspec tests"
task :spec => [:check_dependencies, "spec:fast"]

namespace :frontend do
  task :npm_install do
    Dir.chdir("frontend"){ sh *%w{npm install} }
  end

  task :bundle_install do
    Dir.chdir("frontend"){ sh *%w{bundle install} }
  end

  task :setup => [:npm_install, :bundle_install]
end

namespace :backend do
  task :bundle_install do
    # this is a standard bundle install -- we may need to do some configs
    # on next deploy to capistrano to copy in a bundler config file so
    # it uses --deployment
    Bundler.with_clean_env do
      Dir.chdir("backend"){ sh *%w{bundle install} }
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

DEFAULT_RELOAD_PORT = 35729
DEFAULT_RAILS_PORT  = 3000

namespace :develop do
  def port_offset
    @port_offset ||= if !ENV['PORT_OFFSET'].nil?
                       ENV['PORT_OFFSET'].to_i
                     else
                       0
                     end.tap do |offset|
                       puts "Shifting server ports by #{offset}"
                     end
  end
  def reload_server_port
    DEFAULT_RELOAD_PORT + port_offset
  end
  def rails_server_port
    DEFAULT_RAILS_PORT + port_offset
  end

  def manager
    @manager ||= ChildManager.new.tap do |mngr|
      #Process.setsid
      at_exit{
        mngr.kill_all
      }
    end
  end

  task :launch_browser do
    fork do
      require 'net/http'
      require 'json'

      setup_time_limit = 60
      begin_time = Time.now
      begin
        test_conn =  TCPSocket.new 'localhost', reload_server_port
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

      started = Time.now
      max_wait = 16

      changes = {}
      while(Time.now - started < max_wait)
        changes = JSON.parse(Net::HTTP.get(URI("http://localhost:#{reload_server_port}/changed")))
        if changes["clients"].empty?
          sleep 0.25
        else
          break
        end
      end

      if changes["clients"].empty?
        puts "No running development browsers: launching...."
        p changes

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

        sh cmd, "http://localhost:#{rails_server_port}/"
      else
        puts "There's already a browser attached to the LiveReload server."
        p changes["clients"].first
      end
    end
  end

  task :grunt_watch => 'frontend:setup' do
    manager.start_child("Grunt", "frontend") do
      sh *%w{bundle exec node_modules/.bin/grunt watch:develop}
    end
  end

  task :rails_server => [:links, 'backend:setup'] do
    words = %w{bundle exec rails server}
    words << "-p#{rails_server_port}"
    manager.start_child("Rails", "backend") do
      puts %x"which rails"
      puts %x"bundle exec which rails"
      sh *words
    end
  end

  task :sidekiq do
    manager.start_child("Sidekiq", "backend") do
      sh *%w{bundle exec sidekiq}
    end
  end

  task :wait do
    Process.waitall
  end

  task :links do
    %w{index.html assets fonts}.each do |thing|
      sh "ln", "-sfn", "../../frontend/bin/#{thing}", "backend/public/#{thing}"
    end
  end

  task :startup => [:links, :grunt_watch, :rails_server, :launch_browser, :sidekiq]

  task :all => [:startup, :wait]
end

namespace :spec do

  task :grunt_ci_test => 'frontend:setup' do
    Bundler.with_clean_env do
      Dir.chdir("frontend"){
        sh *%w{bundle exec node_modules/.bin/grunt ci-test}
      }
    end
  end

  task :links do
    %w{index.html assets fonts}.each do |thing|
      sh "ln", "-sfn", "../../frontend/bin/#{thing}", "backend/public/#{thing}"
    end
  end

  task :full, [:spec_files] => [:check_dependencies, :grunt_ci_test, :links, 'backend:setup'] do |t, args|
    Bundler.with_clean_env do
      Dir.chdir("backend"){
        commands = %w{bundle exec rspec}
        if args[:spec_files]
          commands.push(args[:spec_files])
        end
        sh *commands
      }
    end
  end

  desc "Run all feature specs, repeating with each browser width as default"
  task :responsivity, [:spec_files] => [:links, 'backend:setup'] do |t, args|
    Bundler.with_clean_env do
      %w{mobile small medium desktop}.each do |size|
        Dir.chdir("backend"){
          ENV['BROWSER_SIZE']=size
          commands = ["bundle", "exec", "rspec", "-o", "tmp/rspec_#{size}.txt"]
          if args[:spec_files]
            commands.push(args[:spec_files])
          else
            commands.push('spec/features')
          end
          sh *commands rescue true
        }
      end
    end
  end

  task :fast, [:spec_files] => [:links, 'backend:setup'] do |t, args|
    Bundler.with_clean_env do
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
end

namespace :build do
  task :all => %w{frontend:all backend:all}

  namespace :frontend do
    task :grunt_compile => ['frontend:setup'] do
      Bundler.with_clean_env do
        Dir.chdir("frontend"){ sh *%w{bundle exec node_modules/.bin/grunt compile} }
      end
    end

    task :all => [:grunt_compile]
  end

  task :frontend_to_assets do
    sh *%w{cp -a frontend/bin/* backend/public/}
  end

  task 'backend:assets_precompile' => :frontend_to_assets
end

task :check_dependencies => 'backend:bundle_install' do
  Bundler.with_clean_env do
    Dir.chdir("backend") do
      sh "bundle exec rake dependencies:check"
    end
  end
end

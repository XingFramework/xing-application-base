require 'child-manager'
require 'tmux-manager'

DEFAULT_RELOAD_PORT = 35729
DEFAULT_RAILS_PORT  = 3000
DEFAULT_STATIC_PORT  = 9292

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

  def static_server_port
    DEFAULT_STATIC_PORT + port_offset
  end

  def manager
    @manager ||=
      begin
        if TmuxManager.available?
          TmuxPaneManager.new
        else
          ChildManager.new.tap do |mngr|
            at_exit{ mngr.kill_all }
          end
        end
      end.tap do |mgr|
        puts "Using #{mgr.class.name}"
      end
  end

  def manager=(manager)
    @manager=manager
  end

  def clean_run(dir, shell_cmd, env_hash=nil)
    env_hash ||= {}
    Bundler.with_clean_env do
      env_hash.each_pair do |name, value|
        ENV[name] = value
      end
      Dir.chdir(dir) do
        sh(*shell_cmd)
      end
    end
  end

  task :launch_browser do
    fork do
      require 'net/http'
      require 'json'

      setup_time_limit = 60
      begin_time = Time.now
      begin
        test_conn = TCPSocket.new 'localhost', reload_server_port
      rescue Errno::ECONNREFUSED
        if Time.now - begin_time > setup_time_limit
          puts "Couldn't connect to test server on localhost:#{reload_server_port} after #{setup_time_limit} seconds - bailing out"
          exit 1
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
        puts
        puts "No running development browsers: launching...."
        p changes

        cmds = %w{open xdg-open chrome chromium}
        cmd = nil
        begin
          cmd = cmds.shift
          %x{which #{cmd}}
        rescue
          if cmds.empty?
            warn "Can't find any executable to launch a browser with. (WTF?) --jdl"
          else
            retry
          end
        end

        sh cmd, "http://localhost:#{static_server_port}/"
      else
        puts
        puts "There's already a browser attached to the LiveReload server."
        p changes["clients"].first
      end
    end
  end

  task :grunt_watch do
    manager.start_child("Grunt", 'develop:service:grunt_watch')
  end

  task :rails_server do
    manager.start_child("Rails", 'develop:service:rails_server')
  end

  task :sidekiq do
    manager.start_child("Sidekiq", 'develop:service:sidekiq')
  end

  task :static_assets do
    manager.start_child("Static", 'develop:service:static_assets')
  end

  namespace :service do
    task :grunt_watch => 'frontend:setup' do
      clean_run("frontend", %w{bundle exec node_modules/.bin/grunt watch:develop})
    end

    task :rails_server => 'backend:setup' do
      words = %w{bundle exec rails server}
      words << "-p#{rails_server_port}"
      clean_run("backend", words)
    end

    task :sidekiq do
      clean_run("backend", %w{bundle exec sidekiq})
    end

    task :static_assets do
      words = %w{bundle exec rackup}
      words << "-p#{static_server_port}"
      words << "static-app.ru"
      clean_run(".", words, {"LRD_BACKEND_PORT" => "#{rails_server_port}"})
    end
  end

  task :wait do
    manager.wait_all
  end

  task :startup => [:grunt_watch, :static_assets, :rails_server, :launch_browser, :sidekiq]

  task :all => [:startup, :wait]
end

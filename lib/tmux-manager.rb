class TmuxManager
  def initialize
    @first_child = true
    @extra_config_path='~/.lrd-dev-tmux.conf'
  end

  def self.available?
    system("which tmux")
  end

  def copied_env_vars
    %w{PORT_OFFSET}
  end

  def default_env
    {"PORT_OFFSET" => 0}
  end

  def session_env_string
    copied_env_vars.map do |varname|
      varvalue = ENV[varname] || default_env[varname]
      if varvalue.nil?
        ""
      else
        "set-environment #{varname} #{varvalue}"
      end
    end.join(" \\; ")
  end

  def wait_all
    path = File.expand_path(@extra_config_path)
    if File.exists?(path)
      puts "Loading #{path}"
      tmux "source-file #{path}"
    else
      puts "No extra config found at #{path}"
    end

    tmux "attach-session -d" unless existing?
  end

  def existing?
    !(ENV['TMUX'].nil? or ENV['TMUX'].empty?)
  end

  def tmux(cmd)
    str = %{#{tmux_exe} #{cmd}}
    puts str
    %x{#{str}}
  end

  def tmux_exe
    @tmux_exe ||= %x{which tmux}.chomp
  end
end

class TmuxPaneManager < TmuxManager
  def initialize
    super
    @window_name = "Dev Servers"
  end
  attr_accessor :window_name

  def start_child(name, task)
    if @first_child
      if tmux('list-windows -F \'#{window_name}\'') =~ /#{name}|#{@window_name}/
        puts "It looks like there are already windows open for this tmux?"
        exit 2
      end

      if existing?
        tmux session_env_string
        tmux "new-window -n '#@window_name' 'bundle exec rake #{task}' \\; set-window-option remain-on-exit on"
      else
        tmux "new-session -d -n '#@window_name' 'bundle exec rake #{task}' \\; set-window-option remain-on-exit on"
      end
    else
      tmux session_env_string
      tmux "new-window -d -n '#{name}' 'bundle exec rake #{task}' \\; set-window-option remain-on-exit on"
      tmux "join-pane -s 0:#{name}"
    end
    @first_child = false
  end

  def wait_all
    tmux "select-layout -t '#@window_name' tiled"
    super
  end
end

class TmuxWindowManager < TmuxManager
  def start_child(name, task)
    if @first_child
      if tmux 'list-windows -F \'#{window_name}\'' =~ /#{name}/
        puts "It looks like there are already windows open for this tmux?"
        exit 2
      end
    end

    if @first_child and not existing?
      tmux "new-session -d -n '#{name}' 'bundle exec rake #{task}' \\; set-window-option remain-on-exit on"
    else
      tmux session_env_string
      tmux "new-window -n '#{name}' 'bundle exec rake #{task}' \\; set-window-option remain-on-exit on"
    end
    @first_child = false
  end
end

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

  MINIMUM_WINDOW_COLUMNS = 75
  MINIMUM_WINDOW_LINES = 18

  def initialize
    super
    @window_name = "Dev Servers"
    @pane_count = 0
    @window_count = 1
    min_lines = (ENV["XING_TMUX_MIN_LINES"] || MINIMUM_WINDOW_LINES).to_i
    min_cols = (ENV["XING_TMUX_MIN_COLS"] || MINIMUM_WINDOW_COLUMNS).to_i
    lines = %x{tput lines}.to_i
    cols = %x{tput cols}.to_i
    if lines > min_lines * 3
      @new_window_after = 3
    elsif lines > min_lines * 2
      @new_window_after = 2
    else
      @new_window_after = 1
    end
    if cols > min_cols * 2
      @layout = "tiled"
      @new_window_after = @new_window_after * 2
    else
      @layout = "even-vertical"
    end
  end
  attr_accessor :window_name

  def open_new_pane(name, task)
    tmux session_env_string
    tmux "new-window -d -n '#{name}' 'bundle exec rake #{task}' \\; set-window-option remain-on-exit on"
    tmux "join-pane -d -s '#{name}.0' -t '#{@window_name}.bottom'"
  end

  def open_first_window(name, task)
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
  end

  def open_additional_window(name, task)
    tmux "select-layout -t '#@window_name' #{@layout}"
    @window_count = @window_count + 1
    @window_name = "Dev Servers #{@window_count}"
    tmux "new-window -d -n '#@window_name' 'bundle exec rake #{task}' \\; set-window-option remain-on-exit on"
    @pane_count = 0
  end

  def start_child(name, task)
    if @first_child
      open_first_window(name, task)
    elsif @pane_count >= @new_window_after
      open_additional_window(name, task)
    else
      open_new_pane(name, task)
    end
    @pane_count = @pane_count + 1
    @first_child = false
  end

  def wait_all
    tmux "select-layout -t '#@window_name' #{@layout}"
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

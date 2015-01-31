class ChildManager
  def initialize
    @child_pids = []
    @parent_pid = Process.pid
    @child_data = {}
  end
  attr_accessor :child_pids, :child_data

  ChildRecord = Struct.new(:name, :status)

  def start_child(name, task)
    child_pid = Process.fork do
      Signal.trap("HUP") do
        puts "Parent exited"
        exit
      end

      exec(*(%w{bundle exec rake} + [task]))
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

  def wait_all
    Process.waitall
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

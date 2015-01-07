module DependencyUtils
  require 'pp'
  def sh_or_fail(command, fail_message)
    unless (sh command)
      dep_fail fail_message
    end
  end

  def dep_fail(fail_message, details = nil)
    message = "Dependency Failed: " + fail_message
    message += "  (Details below):\n#{details.pretty_inspect}" if details
    puts message
    exit 1
  end

  def dep_success(message)
    puts message
  end
end

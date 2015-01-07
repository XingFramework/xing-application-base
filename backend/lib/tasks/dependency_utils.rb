module DependencyUtils
  def sh_or_fail(command, fail_message)
    unless (sh command)
      dep_fail fail_message
    end
  end

  def dep_fail(fail_message)
    fail "Dependency Failed: " + fail_message
  end

  def dep_success(message)
    puts message
  end
end



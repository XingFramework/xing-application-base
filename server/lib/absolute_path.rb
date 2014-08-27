module AbsolutePath

  def absolute_path(path)
    return path if (path =~ /:\/\//) or (path =~ /^\//)
    "/#{path}"
  end

end

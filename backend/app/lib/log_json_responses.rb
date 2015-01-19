class LogJson
  APPJSON_RE = %r{^application/json}.freeze

  def log_string(string)
    obj = JSON.parse(string)
    pretty_str = JSON.pretty_unparse(obj)
    Rails.logger.debug("Response: " + pretty_str)
  end
end

class LogJsonRequests < LogJson
  def initialize(app)
    @app = app
  end

  def call(env)
    if defined?(Rails) and env["HTTP_CONTENT_TYPE"] =~ APPJSON_RE
      log_string(env["rack.input"].read)
      env["rack.input"].rewind
    end
    @app.call(env)
  end
end

class LogJsonResponses < LogJson
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env).tap do |status, headers, response|
      if defined?(Rails) and headers["Content-Type"] =~ APPJSON_RE
        log_string(response.body)
      end
    end
  end
end

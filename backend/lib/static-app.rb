module LrdCms2
  class BackendUrlCookie
    def initialize(app, backend_url)
      @backend_url = backend_url
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      headers["Set-Cookie"] = [(headers["Set-Cookie"]), "lrdBackendUrl=#@backend_url"].compact.join(";") unless @backend_url.nil?
      [ status, headers, body ]
    end
  end

  class GotoParam
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      default = [ status, headers, body ]
      request_path = env["SCRIPT_NAME"] + env["PATH_INFO"]
      redirect = [ 301, headers.merge("Location" => "/?goto=#{request_path}"), [] ] #possible SCRIPT_NAME needs to be prefixed

      return default unless status == 404
      return default if /\A(assets|fonts|system)/ =~ request_path
      return default if /\.(xml|html|ico|txt)\z/ =~ request_path
      return default if /goto=/ =~ env["QUERY_STRING"]

      return redirect
    end
  end

  class StaticApp
    def self.build(root_path, backend_port)
      backend_url = "http://localhost:#{backend_port}/"
      Rack::Builder.new do
        use BackendUrlCookie, backend_url
        use GotoParam
        use Rack::Static, {
          :urls => [""],
          :root => root_path,
          :index => "index.html",
          :header_rules => {
            :all => {"Cache-Control" => "no-cache, max-age=0" } #no caching development assets
          }
        }
        run proc{}
      end
    end
  end
end

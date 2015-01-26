module LrdCms2
  class BackendUrlCookie
    def initialize(app, backend_url)
      @backend_url = backend_url
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      headers["Set-Cookie"] = [(headers["Set-Cookie"]), "lrdBackendUrl=#@backend_url"].compact.join(";") unless @backend_url.nil?
      p headers["Set-Cookie"]
      puts %x{netstat -tupln}
      [ status, headers, body ]
    end
  end

  class StaticApp
    def self.build(root_path, backend_port)
      backend_url = "http://localhost:#{backend_port}/"
      Rack::Builder.new do
        use BackendUrlCookie, backend_url
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

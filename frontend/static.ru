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

use BackendUrlCookie, ENV["LRD_BACKEND_URL"]
use Rack::Static, :urls => [""], :root => "bin", :index => "index.html", :header_rules => {
  :all => {"Cache-Control" => "no-cache, max-age=0" } #no caching development assets
}
run lambda {|env|
  puts "Missed request - returning 404"
  p env
  [ 404, {}, ["Missing"]]
}

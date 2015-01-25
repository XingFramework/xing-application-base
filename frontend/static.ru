class BackendUrlCookie
  def initialize(app, backend_url)
    @backend_url = backend_url
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    headers["Set-Cookie"] = [(headers["Set-Cookie"]), "lrdBackendUrl=#@backend_url"].compact.join(";") unless @backend_url.nil?
    puts "Cookies set: #{headers["Set-Cookie"].inspect}"
    [ status, headers, body ]
  end
end

use BackendUrlCookie, ENV["LRD_BACKEND_URL"]
use Rack::Static, :urls => [""], :root => "bin", :index => "index.html"
run lambda {|env|
  p env
  [ 404, {}, ["Missing"]] }

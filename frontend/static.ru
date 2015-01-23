use Rack::Static, :urls => [""], :root => "bin", :index => "index.html"
run lambda {|env| [ 404, {}, ["Missing"]] }

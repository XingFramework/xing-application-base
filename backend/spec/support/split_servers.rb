require 'static-app'

Capybara.configure do |capy|
  backend_server = Capybara::Server.new(Capybara.app)
  backend_server.boot
  puts "\n#{__FILE__}:#{__LINE__} => #{backend_server.port.inspect}"
  Capybara.app = LrdCms2::StaticApp.build("../frontend/bin", backend_server.port)
end

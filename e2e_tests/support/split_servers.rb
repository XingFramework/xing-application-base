require File.expand_path('../static-app', __FILE__)

puts "Attempting to start static assets server"

Capybara.configure do |capy|
  backend_server = Capybara::Server.new(Capybara.app)
  backend_server.boot
  Capybara.app = Xing::StaticApp.build("../frontend/bin", backend_server.port)
  RSpec.configure do |config|
    config.waterpig_clearable_logs << 'test_static'
  end
end

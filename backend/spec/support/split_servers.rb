require 'static-app'

Capybara.configure do |capy|
  backend_server = Capybara::Server.new(Capybara.app)
  backend_server.boot
  Capybara.app = LrdCms2::StaticApp.build("../frontend/bin", backend_server.port)
  RSpec.configure do |config|
    config.waterpig_clearable_logs << 'test_static'
  end
end

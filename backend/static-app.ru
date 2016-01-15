require 'xing/dev-assets'
run Xing::DevAssets::RackApp.build("../frontend/bin", ENV['XING_BACKEND_PORT']) do |app|
  app.log_root = File.expand_path("../log", __FILE__)
end

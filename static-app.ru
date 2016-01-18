require 'xing/dev-assets'
run (Xing::DevAssets::RackApp.build(File.expand_path("../frontend/bin", __FILE__), Integer(ENV['XING_BACKEND_PORT'])) do |app|
  app.log_root = File.expand_path("../backend/log", __FILE__)
  app.log_level = :debug
end)

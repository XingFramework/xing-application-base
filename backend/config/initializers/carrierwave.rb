# CarrierWave.configure do |config|
#   config.asset_host = proc do |file|
#     identifier = # some logic
#     "http://#{identifier}.cdn.rackspacecloud.com"
#   end
# end

CarrierWave.configure do |config|
  config.storage = :file
  config.asset_host = ActionController::Base.asset_host
end

RSpec.configure do |config|
  config.before(:step) do |example|
    puts "Step: #{example.description}"
    Rails.logger.debug "Step: #{example.description}"
  end
end

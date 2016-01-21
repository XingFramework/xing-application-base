Dir[File.expand_path('../../../backend/spec/factories/**/*.rb', __FILE__)].each do |path|
  require path
end

RSpec.configure do |config|
  # additional factory_girl configuration

  puts FactoryGirl.factories
  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end

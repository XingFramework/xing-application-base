require 'capybara/rspec'
#require 'selenium-webdriver'
require 'capybara/email/rspec'
require 'stringio'

class WarningSuppressor
  class << self
    def write(message)
      if message =~ /QFont::setPixelSize: Pixel size <= 0/ || message =~/CoreText performance note:/ then 0 else puts(message);1;end
    end
  end
end

Capybara.register_driver(:selenium_chrome) do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :poltergeist_debug do |app|
  Capybara::Poltergeist::Driver.new(app, :inspector => true, phantomjs_logger: WarningSuppressor)
end

Capybara.javascript_driver = (ENV['CAPYBARA_DRIVER'] || :selenium_chrome).to_sym


module SnapStep
  def self.included(steps)
    steps.after(:step) do
      save_snapshot(example.metadata[:snapshots_into], example.description.downcase.gsub(/\s+/, "-"))
    end
  end
end



module BrowserTools
  def accept_alert
    alert = page.driver.browser.switch_to.alert
    alert.accept
  end

  def attr_includes(attr, value)
    "contains(concat(' ', normalize-space(@#{attr}), ' '), ' #{value} ')"
  end

  def class_includes(value)
    attr_includes("class", value)
  end

  def self.warnings
    @warnings ||= {}
  end

  def self.warn(general, specific=nil)
    warnings.fetch(general) do
      warnings[general] = true
      puts "Warning: #{general}#{specific ? ": #{specific}" : ""}"
    end
  end

  def frame_index(dir)
    @frame_dirs ||= Hash.new do |h,k|
      FileUtils.rm_rf(k)
      FileUtils.mkdir_p(k)
      h[k] = 0
    end
    @frame_dirs[dir] += 1
  end

  def save_snapshot(dir, name)
    require 'fileutils'

    dir = "tmp/#{dir}"

    path = "#{dir}/#{"%03i" % frame_index(dir)}-#{name}.png"
    page.driver.save_screenshot(path, :full => true)

    yield path if block_given?
  rescue Capybara::NotSupportedByDriverError => nsbde
    BrowserTools.warn("Can't use snapshot", nsbde.inspect)
  end

  def snapshot(dir)
    require 'fileutils'

    dir = "tmp/#{dir}"

    @frame_dirs ||= Hash.new do |h,k|
      puts "Clearing #{k}"
      FileUtils.rm_rf(k)
      FileUtils.mkdir_p(k)
      h[k] = 0
    end
    frame = (@frame_dirs[dir] += 1)

    path = "#{dir}/#{"%03i" % frame}.png"
    msg = "Saving screenshot: #{path} (from: #{caller[0]})"
    puts msg
    Rails.logger.info(msg)
    page.driver.save_screenshot(path, :full => true)
  rescue Capybara::NotSupportedByDriverError => nsbde
    BrowserTools.warn("Can't use snapshot", nsbde.inspect)
  end

end


RSpec.configure do |config|
  config.include BrowserTools, :type => :feature
  config.include SnapStep, :snapshots_into => proc{|v| v.is_a? String}
end

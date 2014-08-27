require 'capybara/rspec'
#require 'selenium-webdriver'
require 'capybara/poltergeist'
require 'rspec-steps'
require 'stringio'

Capybara.register_driver(:selenium_chrome) do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :poltergeist_debug do |app|
  Capybara::Poltergeist::Driver.new(app, :inspector => true, :phantomjs_logger => StringIO.new, :js_errors => false)
end

Capybara.javascript_driver = (ENV['CAPYBARA_DRIVER'] || :poltergeist_debug).to_sym

module CKEditorTools
  def fill_in_ckeditor(id, options = {})
    raise "Must pass a hash containing 'with'" if not options.is_a?(Hash) or not options.has_key?(:with)
    raise "CKEeditor fill-in only works with Selenium driver" unless page.driver.class == Capybara::Selenium::Driver
    browser = page.driver.browser
    browser.execute_script("CKEDITOR.instances['#{id}'].setData('#{options[:with]}');")
  end
end

module TinyMCETools
  def fill_in_tinymce(id, options = {})
    content =
      case options
      when Hash
        content = options.fetch(:with)
      when String
        options
      else
        raise "Must pass a string or a hash containing 'with'"
      end

    case page.driver
    when Capybara::Selenium::Driver
      page.execute_script("$('##{id}').tinymce().setContent('#{content}')")
    when Capybara::Poltergeist::Driver
      within_frame("#{id}_ifr") do
        element = find("body")
        element.native.send_keys(content)
      end
    else
      raise "fill_in_tinymce called with unrecognized page.driver: #{page.driver.class.name}"
    end
  end
end

module BrowserTools
  def accept_alert
    if poltergeist?
      # do nothing ... really?
      # https://github.com/jonleighton/poltergeist/issues/50
      # Poltergeist's behavior is to return true to window.alert
      # Does mean it's a challenge to test cancelling e.g. deletes, or
      # confirming that an alert happens even
    else
      alert = page.driver.browser.switch_to.alert
      alert.accept
    end
  end

  #renders the xpath to properly match a css class (or other space separated
  #attribute)
  #Use like: div[#{attr_includes("class", "findme")}]
  #
  def attr_includes(attr, value)
    "contains(concat(' ', normalize-space(@#{attr}), ' '), ' #{value} ')"
  end

  def class_includes(value)
    attr_includes("class", value)
  end

  def wait_for_animation
    sleep(1) if poltergeist?
  end

  def poltergeist?
    Capybara.javascript_driver.to_s =~ /poltergeist/
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
      puts "Clearing #{k} to store snapshots in"
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
    save_snapshot(dir, "debug") do |path|
      msg = "Saved screenshot: #{path} (from: #{caller[0].sub(/^#{Dir.pwd}/,'')})"
      puts msg
      Rails.logger.info(msg)
    end
  end
end

module SnapStep
  def self.included(steps)
    steps.after(:step) do
      save_snapshot(example.metadata[:snapshots_into], example.description.downcase.gsub(/\s+/, "-"))
    end
  end
end

RSpec.configure do |config|
  config.include BrowserTools, :type => :feature
  config.include TinyMCETools, :type => :feature

  config.include SnapStep, :snapshots_into => proc{|v| v.is_a? String}
end

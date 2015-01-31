require 'selenium-webdriver'
require 'site_snapshot'
require 'snapshot_writer'

class LocalSiteSnapshot < SiteSnapshot
  include SnapshotWriter

  def initialize(url)
    super(url)
    @wait = Selenium::WebDriver::Wait.new
  end

  def setup
    @driver = Selenium::WebDriver.for :chrome
  end
  attr_accessor :driver, :wait

  def teardown
    @driver.close
  end

  def fetch(url, path)
    @driver.navigate.to(url+path)
    # better way to wait till javascript complete?
    @wait.until do
      @driver.execute_script("return window.frontendContentLoaded == true;")
    end
    element = @driver.find_element(:tag_name, "html")
    html = element.attribute("outerHTML")
    write(path, html)
  end
end

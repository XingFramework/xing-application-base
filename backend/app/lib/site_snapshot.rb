require "selenium-webdriver"
require "site_page_set"

class SiteSnapshot
  class << self
    def create!(url)
      @sitemap_page_set = SitePageSet.new(url)
      @driver = Selenium::WebDriver.for :chrome
      @wait = Selenium::WebDriver::Wait.new
      generate_snapshot
      @driver.close
    end

    def generate_snapshot
      @sitemap_page_set.visit_pages do |url, path|
        @driver.navigate.to(url+path)
        # better way to wait till javascript complete?
        @wait.until do
          @driver.execute_script("return window.frontendContentLoaded == true;")
        end
        element = @driver.find_element(:tag_name, "html")
        html = element.attribute("outerHTML")
        if Rails.env.test?
          snapshot_file = "#{ Rails.root }/spec/fixtures/sitemap_scratch/#{path.present? ? path : 'index'}.html"
        else
          snapshot_file = "#{ Rails.root }/public/frontend_snapshots/#{path.present? ? path : 'index'}.html"
        end
        dirname = File.dirname(snapshot_file)
        unless File.directory?(dirname)
          FileUtils.mkdir_p(dirname)
        end

        File.open(snapshot_file, "w+") do |f|
          f.write(html)
        end
      end
    end
  end
end

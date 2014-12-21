require "site_page_set"

class SiteSnapshot
  class << self
    def create!(url)
      @sitemap_page_set = SitePageSet.new(url)
      setup
      generate_snapshot
      teardown
    end

    def setup
    end

    def generate_snapshot
      @sitemap_page_set.visit_pages do |url, path|
        fetch(url, path)
      end
    end

    def fetch(url, path)
    end

    def teardown
    end

  end
end

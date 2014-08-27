require 'builder'

class Sitemap

  class << self
    def create!(url = nil)
      @bad_pages = []
      @pages_to_visit = []
      if url
        @url = url
      elsif defined? SITEMAP_DEFAULT_URL
        @url = SITEMAP_DEFAULT_URL
      else
        @url = "http://CHANGEME.com/"  #TODO: edit for each client
      end

      @url_domain = @url[/([a-z0-9-]+)\.([a-z.]+)/i]

      @pages_to_visit = Page.published.collect { |p| p.permalink }
      generate_sitemap
      update_search_engines if Rails.env.production?
    end

    private
    def generate_sitemap
      xml_str = ""
      xml = Builder::XmlMarkup.new(:target => xml_str, :indent => 2)

      xml.instruct!
      xml.urlset(:xmlns=>'http://www.sitemaps.org/schemas/sitemap/0.9') {
        @pages_to_visit.each do |url|
          unless @url == url
            xml.url {
              xml.loc(@url + url)
              xml.lastmod(Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00"))
             }
          end
        end
      }

      save_file(xml_str)
    end
    def save_file(xml)
      File.open("#{ Rails.root }/public/sitemap.xml", "w+") do |f|
        f.write(xml)
      end
    end

     def update_search_engine(host, path, sitemap_uri)
      Rails.logger.info{"Notifying #{host}"}
      begin
        res = Net::HTTP.get_response(host, path + sitemap_uri)
      rescue Object => ex
        Rails.logger.info "Error while notifying #{host}: #{ex.inspect}"
      end
      Rails.logger.info res.class
    end

    # Notify popular search engines of the updated sitemap.xml
    def update_search_engines
      sitemap_uri = @url + 'sitemap.xml'
      escaped_sitemap_uri = CGI.escape(sitemap_uri)

      update_search_engine('www.google.com', '/webmasters/tools/ping?sitemap=', escaped_sitemap_uri)
      update_search_engine('search.yahooapis.com', '/SiteExplorerService/V1/updateNotification?appid=SitemapWriter&url=', escaped_sitemap_uri)
      update_search_engine('www.bing.com', '/webmaster/ping.aspx?siteMap=', escaped_sitemap_uri)
    end

  end
end

class SitePageSet
  def initialize(url)
    @pages_to_visit = []
    if url
      @url = url
    elsif defined? SITEMAP_DEFAULT_URL
      @url = SITEMAP_DEFAULT_URL
    else
      @url = "http://CHANGEME.com/"  #TODO: edit for each client
    end

    @url_domain = @url[/([a-z0-9-]+)\.([a-z.]+)/i]
    @pages_to_visit = Page.published.where.not(type: "Page::Homepage").collect { |p| p.url_slug }
  end

  def visit_pages(&block)
    STATIC_PATHS_FOR_SITEMAP.each do |path|
      yield(@url,path)
    end

    @pages_to_visit.each do |path|
      if PAGES_FRONTEND_URL.present?
        path = PAGES_FRONTEND_URL + "/" + path
      else
        path = + path
      end
      yield(@url, path)
    end
  end
end

class SitePageSet
  include DomainHelpers

  def initialize(url)
    @url = domain(url)
    @pages_to_visit = Page.published.where.not(type: "Page::Homepage").collect { |p| p.url_slug }
  end

  def visit_pages(&block)
    STATIC_PATHS_FOR_SITEMAP.each do |path|
      yield(@url,path)
    end

    @pages_to_visit.each do |path|
      path = page_frontend_url(path)
      yield(@url, path)
    end
  end
end

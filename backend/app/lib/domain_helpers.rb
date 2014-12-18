module DomainHelpers
  def domain(url = nil)
    if url
      url
    elsif defined? SITEMAP_DEFAULT_URL
      SITEMAP_DEFAULT_URL
    else
      "http://CHANGEME.com/"  #TODO: edit for each client
    end
  end

  def page_frontend_url(path)
    if PAGES_FRONTEND_URL.present?
      PAGES_FRONTEND_URL + "/" + path
    else
      path
    end
  end
end

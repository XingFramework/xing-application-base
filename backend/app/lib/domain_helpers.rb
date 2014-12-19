module DomainHelpers
  def domain(url = nil)
    if url
      url
    elsif defined? Rails.application.secrets.sitemap_base_url
      Rails.application.secrets.sitemap_base_url
    else
      "http://CHANGEME.com/"

      # TODO: should we raise an exception here instead?
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

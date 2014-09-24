class SitemapObserver < ActiveRecord::Observer
  observe :page

  def after_create(page)
    regenerate_sitemap
  end

  def after_update(page)
    regenerate_sitemap
  end

  def after_destroy(page)
    regenerate_sitemap
  end

  def regenerate_sitemap
    Sitemap.create! unless Rails.env.test?
  end
end
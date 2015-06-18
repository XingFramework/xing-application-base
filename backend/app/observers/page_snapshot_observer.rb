class PageSnapshotObserver < ActiveRecord::Observer
  include DomainHelpers
  observe :page

  def after_create(page)
    take_snapshot(page)
  end

  def after_update(page)
    take_snapshot(page)
  end

  def after_destroy(page)
    take_snapshot(page)
  end

  def take_snapshot(page)
    unless Rails.env.test?
      if page.type == "Page::Homepage"
        path = ""
      else
        path = page_frontend_url(page.url_slug)
      end
      Xing::Services::SnapshotFetcher.perform_async(self.domain, path)
    end
  end
end

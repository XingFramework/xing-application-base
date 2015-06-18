require 'site_snapshot'

class RemoteSiteSnapshot < SiteSnapshot
  def setup
    @fetcher = Xing::Services::SnapshotFetcher.new
  end

  def fetch(url, path)
    @fetcher.perform(url, path)
  end
end

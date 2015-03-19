require 'site_snapshot'

class RemoteSiteSnapshot < SiteSnapshot
  def setup
    @fetcher = RemoteSnapshotFetcher.new
  end

  def fetch(url, path)
    @fetcher.perform(url, path)
  end
end

require 'site_snapshot'
require 'remote_snapshot_fetcher'

class RemoteSiteSnapshot < SiteSnapshot
  def setup
    @fetcher = RemoteSnapshotFetcher.new
  end

  def fetch(url, path)
    @fetcher.perform(url, path)
  end
end

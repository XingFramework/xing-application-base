require 'spec_helper'

describe RemoteSiteSnapshot do

  let :site_page_set do
    double(SitePageSet)
  end

  let :remote_snapshot_fetcher do
    double(RemoteSnapshotFetcher)
  end

  # This feels like way too much mocking, but dont know how to test without completely
  # turning off selenium
  before do
    expect(RemoteSnapshotFetcher).to receive(:new).and_return(remote_snapshot_fetcher)
    expect(SitePageSet).to receive(:new).with("http://www.awesome.com/").and_return(site_page_set)
    expect(site_page_set).to receive(:visit_pages).and_yield("http://www.awesome.com/", "test", Time.now)
  end

  it "should read html contents from remote server and output to the file" do
    expect(remote_snapshot_fetcher).to receive(:perform).with("http://www.awesome.com/", "test")
    RemoteSiteSnapshot.create!("http://www.awesome.com/")
  end

end

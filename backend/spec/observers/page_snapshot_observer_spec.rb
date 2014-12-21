require 'spec_helper'

describe PageSnapshotObserver, :type => :observer do
  let :homepage do
    Page::Homepage.get
  end

  let :one_column do
    FactoryGirl.create(:one_column_page)
  end

  let :page_snapshot_observer do
    PageSnapshotObserver.instance
  end

  before do
    # eek -- is there a better way to force this code to run?
    expect(Rails.env).to receive(:test?).at_least(:once).and_return(false)
  end

  it "should take snapshots of homepage" do
    expect(RemoteSnapshotFetcher).to receive(:perform_async).with(anything, "")
    page_snapshot_observer.take_snapshot(homepage)
  end

  it "should take snapshots of other pages" do
    expect(RemoteSnapshotFetcher).to receive(:perform_async).with(anything, PAGES_FRONTEND_URL + "/" + one_column.url_slug)
    page_snapshot_observer.take_snapshot(one_column)
  end

end

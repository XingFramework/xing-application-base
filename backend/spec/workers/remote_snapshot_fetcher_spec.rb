require 'spec_helper'

describe RemoteSnapshotFetcher do

  before do
    begin
      FileUtils.mkdir_p("#{ Rails.root }/spec/fixtures/sitemap_scratch")
      File.delete("#{ Rails.root }/spec/fixtures/sitemap_scratch/test.html")
    rescue
    end
  end

  # This feels like way too much mocking, but dont know how to test without completely
  # turning off selenium
  before do
    response = Typhoeus::Response.new(code: 200, body: "some html content")
    Typhoeus.stub(Rails.application.secrets.snapshot_server['url']).and_return(response)
    expect(Typhoeus::Request).to receive(:new).with(Rails.application.secrets.snapshot_server['url'],
      :userpwd => "#{Rails.application.secrets.snapshot_server['user']}:#{Rails.application.secrets.snapshot_server['password']}",
      :params => {
        :url => "http://www.awesome.com/test"
      }
      ).and_call_original
  end

  subject :remote_snapshot_fetcher do
    RemoteSnapshotFetcher.new
  end

  it "should read html contents from remote server and output to the file" do
    remote_snapshot_fetcher.perform("http://www.awesome.com/", "test")
    content = File.read("#{ Rails.root }/spec/fixtures/sitemap_scratch/test.html")
    expect(content).to eq("some html content")
  end

end

require 'spec_helper'

# this is not a feature spec per say, but I couldn't find an easy way to force
# capybara to boot it's HTTP rails server up -- which is what we'll use to take
# snapshots against

steps "server takes snapshot", :js => true, :vcr => {} do
  let :server_url do
    "http://127.0.0.1:#{Capybara.current_session.server.port}/"
  end

  let! :one_column_page do
    FactoryGirl.create(:one_column_page, url_slug: "integration_test").tap do |page|
      headline = page.page_contents.where(:name => :headline).first.content_block
      headline.body = "Welcome to our super site"
      headline.save
      page.reload
    end
  end

  before do
    FileUtils.mkdir_p("#{ Rails.root }/spec/fixtures/sitemap_scratch")

    begin
      File.delete("#{ Rails.root }/spec/fixtures/sitemap_scratch/index.html")
    rescue
    end

    begin
      File.delete("#{ Rails.root }/spec/fixtures/sitemap_scratch/pages/integration_test.html")
    rescue
    end

    LocalSiteSnapshot.create!(server_url)
  end

  it "will take a snapshot of homepage" do
    html = Nokogiri::HTML(File.open("#{ Rails.root }/spec/fixtures/sitemap_scratch/index.html"))
    description = html.css("meta[name=description]").first.attributes["content"].value
    expect(description).to eq(Page::Homepage.get.description)
  end

  it "should create a snapshot of each cms page" do
    html = Nokogiri::HTML(File.open("#{ Rails.root }/spec/fixtures/sitemap_scratch/pages/integration_test.html"))
    expect(html.text).to include("Welcome to our super site")
  end
end

require 'spec_helper'

describe SitePageSet do

  let! :page do
    FactoryGirl.create(:one_column_page, :url_slug => "cherry")
  end

  before do
    expect(STATIC_PATHS_FOR_SITEMAP).to receive(:each).and_yield("awesome")
  end

  subject :sitemap_page_set do
    SitePageSet.new("http://www.sillytown.com/")
  end

  it "iterates over static pages and pages" do
    pages = []
    subject.visit_pages do |domain, path|
      pages << (domain+path)
    end
    expect(pages.count).to eq(2)
    expect(pages).to include("http://www.sillytown.com/#{PAGES_FRONTEND_URL}/cherry")
    expect(pages).to include("http://www.sillytown.com/awesome")
  end

end

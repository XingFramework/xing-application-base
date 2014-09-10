require 'spec_helper'
require 'sitemap'

describe Sitemap do
  describe "with no pages" do
    it "should not crash" do
      Sitemap.create!
    end

  end

  describe "with a couple pages" do
    before(:each) do
      @page_public = FactoryGirl.create(:page, :published => true)
      @page_private = FactoryGirl.create(:page, :publish_start => Time.now + 3.days)
    end

    it "should not crash" do
      Sitemap.create!
    end

    it "should have the appropriate content" do
      Sitemap.create!("http://example.com/")
      xml = Nokogiri::XML(File.open(Rails.root + 'public' + 'sitemap.xml'))

      expect(xml.inner_html).to include('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">')
      expect(xml.inner_html).to include('<loc>')
      expect(xml.inner_html).to include('<lastmod>')
      expect(xml.text).to include('http://example.com/' + @page_public.url_slug)
      expect(xml.text).to include(@page_public.updated_at.utc.strftime('%Y-%m-%dT%H:%M:%S+00:00'))

      expect(xml.text).to_not include('http://example.com/' + @page_private.url_slug)
    end

    it "should have the static paths" do
      xml = Nokogiri::XML(File.open(Rails.root + 'public' + 'sitemap.xml'))
      STATIC_PATHS_FOR_SITEMAP.each do |path|
        expect(xml.text).to include('http://example.com/' + path)
      end
    end
  end
end

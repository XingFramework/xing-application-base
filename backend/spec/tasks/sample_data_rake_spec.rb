require 'spec_helper'
require 'rake'

describe 'db:sample_data namespace rake task',
  :vcr => { :cassette_name => "rake_task/db_sample_data_load", :allow_playback_repeats => true},
  :type => :task do

  before do
    load File.expand_path("../../../lib/tasks/sample_data.rake", __FILE__)
    Rake::Task.define_task(:environment)
  end

  it "should succeed and create reasonable data" do
    Rake::Task["db:sample_data:load"].invoke

    expect(Page::OneColumn.count).to eq(5)
    expect(Page::TwoColumn.count).to eq(1)

    expect(Page::OneColumn.all.map(&:title)).to include("About Us", "Contact Us", "Home", "Gallery", "Links")

    # Should be adjusted once url_slug method is created.
    expect(Page::OneColumn.all.map(&:url_slug)).to include("about_us", "contact_us", "home", "gallery", "links")

    expect(Page::OneColumn.all.map(&:keywords)).to include("about_us", "contact_us", "home", "gallery", "links")

    Page::OneColumn.all.each do |page|
      expect(page.content_blocks.count).to be >= 2
      expect(page.content_blocks.count).to be <= 3
      expect(page.content_blocks.map(&:content_type)).to include("text/html")
      expect(page.content_blocks.map(&:content_type)).to include("text/css") if page.page_contents.count == 3
    end

    Page::OneColumn.all.each do |page|
      expect(page.page_contents.map(&:name)).to include("headline", "main")
      expect(page.page_contents.map(&:name)).to include("styles") if page.contents.count == 3
    end


    expect(Menu.list.length).to eq(2)
    expect(Menu.new('Main Menu').tree.length).to eq(8)

  end
end

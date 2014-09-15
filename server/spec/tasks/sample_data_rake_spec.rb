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

    Page::OneColumn.count.should == 5
    Page::TwoColumn.count.should == 1

    Page::OneColumn.all.map(&:title).should include("About Us", "Contact Us", "Home", "Gallery", "Links")

    # Should be adjusted once url_slug method is created.
    Page::OneColumn.all.map(&:url_slug).should include("about_us", "contact_us", "home", "gallery", "links")

    Page::OneColumn.all.map(&:keywords).should include("about_us", "contact_us", "home", "gallery", "links")

    Page::OneColumn.all.each do |page|
      page.content_blocks.count.should >= 2
      page.content_blocks.count.should <= 3
      page.content_blocks.map(&:content_type).should include("text/html")
      page.content_blocks.map(&:content_type).should include("text/css") if page.page_contents.count == 3
    end

    Page::OneColumn.all.each do |page|
      page.page_contents.map(&:name).should include("headline", "main")
      page.page_contents.map(&:name).should include("styles") if page.contents.count == 3
    end


    expect(Menu.list).to have(2).menus
    expect(Menu.new('Main Menu').tree.length).to eq(7)

  end
end

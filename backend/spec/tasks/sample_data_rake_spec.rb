require 'spec_helper'
require 'rake'

describe 'db:sample_data namespace rake task',
  :vcr => { :cassette_name => "rake_task/db_sample_data_load", :allow_playback_repeats => true},
  :type => :task do

  before do
    Dir.glob("#{Rails.root}/lib/tasks/sample_data/*.rake").each{ |r| load(r) }
    load File.expand_path("../../../lib/tasks/sample_data.rake", __FILE__)
    Rake::Task.define_task(:environment)
  end

  it "should succeed and create reasonable data" do
    Rake::Task["db:sample_data:load"].invoke

    # Here's the default Sample Data generated menu
    # about_us     # 1 col page
    #   newsletter # 2 col page
    #   policies   # 1 col page
    #   google     # external URL link
    # products     # 1 col page
    #   widgets    # 1 col page
    #   thingbobs  # 1 col page
    # contact_us   # 1 col page

    expect(Page::OneColumn.count).to eq(6)
    expect(Page::TwoColumn.count).to eq(1)

    expect(Page::OneColumn.all.map(&:title)).to include("About Us", "Policies", "Products", "Widgets", "Thingbobs", "Contact Us")
    expect(Page::OneColumn.all.map(&:url_slug)).to include("about_us", "policies", "products", "widgets", 'thingbobs', 'contact_us')
    expect(Page::OneColumn.all.map(&:keywords)).to include("about_us", "policies", "products", "widgets", 'thingbobs', 'contact_us')


    Page::OneColumn.all.each do |page|
      expect(page.content_blocks.count).to be >= 2
      expect(page.content_blocks.count).to be <= 3
      expect(page.content_blocks.map(&:content_type)).to include("text/html")
      expect(page.content_blocks.map(&:content_type)).to include("text/css") if page.page_contents.count == 3
      expect(page.page_contents.map(&:name)).to include("headline", "main")
      expect(page.page_contents.map(&:name)).to include("styles") if page.contents.count == 3

      # expect a matching menu item for each page.
      expect(MenuItem.where(:name => page.title).length).to eql(1)
    end

    expect(Menu.list.length).to eq(1)
    expect(Menu.new('Main Menu').tree.length).to eq(9)

  end
end

require 'spec_helper'

shared_steps "Setup for navigation" do
  before :all do
    @page_one = FactoryGirl.create(:one_column_page)
    @page_two = FactoryGirl.create(:two_column_page)
    @page_link = FactoryGirl.create(:menu_item, name: 'Page Link', page: @page_one)
    @path_link = FactoryGirl.create(:menu_item_without_page, name: "Path Link", path: '/#/sign-in')
  end
end

steps "Vistor navigated to a path on desktop", :js => true, :size => :desktop do
  perform_steps "Setup for navigation"

  it "visit root" do
    visit '/'
  end

  it "click on Path Link" do
    click_on("Path Link")
  end

  it "should have right content" do
    expect(page).to have_content("Sign In")
    expect(URI(current_url).path).to eq('/sign-in')
  end
end

steps "Vistor navigated to a page on desktop", :js => true, :size => :desktop do
  perform_steps "Setup for navigation"

  it "visit root" do
    visit '/'
  end

  it "clicks on Page Link" do
    click_on("Page Link")
  end

  it "should have right content" do
    expect(page).to have_content(@page_one.contents["headline"].body)
    expect(page.body).to include(@page_one.contents["main"].body)
    expect(URI(current_url).path).to eq("/pages/" + @page_one.url_slug)
  end
end

steps "Vistor navigated to a path on mobile", :js => true, :size => :mobile do
  perform_steps "Setup for navigation"

  it "visit root" do
    visit '/'
  end

  it "clicks on Menu" do
    click_on("Menu")  # Expand the currently-collapsed menu
  end

  it "clicks on Path Link" do
    click_on("Path Link")
  end

  it "should have right content" do
    expect(page).to have_content("Sign In")
    expect(URI(current_url).path).to eq('/sign-in')
  end
end

require 'spec_helper'

feature "Visitor navigates with the main menu", :js => true, :vcr => {} do

  let :page_one do
    FactoryGirl.create(:one_column_page)
  end

  let :page_two do
    FactoryGirl.create(:two_column_page)
  end

  let! :page_link do
    FactoryGirl.create(:menu_item, name: 'Page Link', parent_id: 1, page: page_one)
  end

  let! :path_link do
    FactoryGirl.create(:menu_item_without_page, name: "Path Link", parent_id: 1, path: 'http://lrdesign.com')
  end

  scenario "visit a path" do
    visit '/'
    click_on("Path Link")
    expect(page).to have_content("Logical Reality")
    expect(URI(current_url).host).to eq('lrdesign.com')
  end

  scenario "visit a page" do
    visit '/'
    click_on("Page Link")
    expect(page).to have_content(page_one.contents["headline"].body)
    expect(page.body).to include(page_one.contents["main"].body)
    expect(URI(current_url).fragment).to eq("/pages/" + page_one.url_slug)
  end

end
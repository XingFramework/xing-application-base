require 'spec_helper'

feature "User Signs In and Edits Homepage", :js => true, :vcr => {} do

  let! :user do
    FactoryGirl.create(:confirmed_user)
  end

  let :homepage do
    Page::Homepage.last
  end

  def edit_homepage
    sign_in_with(user.email, user.password)
    expect(page).to have_content("Sign Out")
    visit "/"
    expect(page).to have_button("Edit This Page")
    click_on("Edit This Page")
  end

  scenario "views homepage to edit" do
    sign_in_with(user.email, user.password)
    expect(page).to have_content("Sign Out")
    visit "/"
    expect(page).to have_title(homepage.title)
    expect(page).to have_content(homepage.contents["headline"])
    expect(page).to have_content(homepage.contents["main"])
    expect(page).to have_button("Edit This Page")
    click_on("Edit This Page")
  end

  scenario "title" do
    edit_homepage
    fill_in "Title", :with => "Brand New Homepage Title"
    click_on("Save")
    expect(page).to have_content("Edit This Page")
    expect(page.title).to include("Brand New Homepage Title")
  end

  scenario "keywords" do
    edit_homepage
    fill_in "Keywords", :with => "this, that, the other thing"
    click_on("Save")
    expect(page).to have_content("Edit This Page")
    find(:xpath, "//meta[@name='keywords']", :visible => false, :text => "this, that, the other thing")
  end

  scenario "description" do
    edit_homepage
    fill_in "Description", :with => "Question your tea spoons."
    click_on("Save")
    expect(page).to have_content("Edit This Page")
    find(:xpath, "//meta[@name='description']", :visible => false, :text => "Question your tea spoons.")
  end

end

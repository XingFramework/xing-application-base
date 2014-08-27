require 'spec_helper'
include TinyMCETools

steps "Admin creates a menu", :snapshots_into => "create-menu", :type => :feature, :js => true do

  it "should load the login page" do
    visit '/login'
  end

  it "when the admin logs in" do
    fill_in("user_login", :with => "admin")
    fill_in("user_password", :with => "wxyz")
    click_button("Login")
  end

  it "and creates two pages" do

    click_link "Edit Pages"
    click_link "New page"
    fill_in "Title",        :with => "The Cool Page"
    fill_in "Permalink",        :with => "cool_page"
    fill_in_tinymce "page_content", :with => "Judson is 29 and Evan is not telling"
    click_button "Save Page"
    click_link "Edit Pages"
    click_link "New page"
    fill_in "Title",        :with => "The Dumb Page"
    fill_in "Permalink",        :with => "dumb_page"
    fill_in_tinymce "page_content", :with => "How should I know how old these people are?"
    click_button "Save Page"
  end

  it "should visit the Edit Menu page" do
    click_link "Edit Menu"
  end

  it "should open the new menu item form" do
    click_link "New Menu Entry"
    page.should have_css("form#new_location")
  end

  it "admin enters a menu item for first page" do
    fill_in "Name", :with => "Coolness"
    select "The Cool Page", :from => "Page"
    select "Home", :from => "Parent"
    click_button "Save Menu Entry"
  end

  it "should show the menu item was created" do
    page.should have_content("Menu Entry was successfully created.")
    page.should have_content("Coolness")
    page.should have_content("The Cool Page")
  end

  it "should open the new menu item form" do
    click_link "New Menu Entry"
    page.should have_css("form#new_location")
  end

  it "admin enters a menu item for the second page" do
    fill_in "Name", :with => "Just stupid"
    select "The Dumb Page", :from => "Page"
    select "Home", :from => "Parent"
    click_button "Save Menu Entry"
  end

  it "should show the menu item was created" do
    page.should have_content("Menu Entry was successfully created.")
    page.should have_content("Just stupid")
    page.should have_content("The Dumb Page")
  end

  it "admin visits the site Homepage" do
    visit "/"
  end

  it "should show the menu" do
    within "div#nav" do
      within "ul#nav_menu" do
        within :xpath, "//li[.//a[@href='/cool_page']]" do
          page.should have_content("Coolness")
        end
        within :xpath, "//li[.//a[@href='/dumb_page']]" do
          page.should have_content("Just stupid")
        end
      end
    end
  end

  it "should visit the Edit Menu page" do
    click_link "Edit Menu"
    page.should have_css("a[href='/cool_page']")
    page.should have_content("Coolness")
  end

  it "when the admin clicks edit" do
    within(:xpath, "//table[#{class_includes('listing')}]//tr[.//td/a[@href='/cool_page']]") do
      click_link "Edit"
    end
    page.should have_css("form.edit_location")
  end

  it "and changes the order of menu items" do
    select "Last", :from => "Move to"
    click_button "Save Menu Entry"
  end

  it "and goes back to the site homepage" do
    visit "/"
  end

  it "should show the menu in the new order" do
    page.should have_xpath("//div[@id='nav']" +
                           "//ul[@id='nav_menu']" +
                           "//li[.//a[contains(text(),'Just stupid')]]/following-sibling::li[.//a[contains(text(),'Coolness')]]")
  end

end

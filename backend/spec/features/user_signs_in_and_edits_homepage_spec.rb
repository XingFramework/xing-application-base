require 'spec_helper'

shared_steps "Setup for homepage" do
  before :all do
    @user = FactoryGirl.create(:confirmed_user)
    @homepage = Page::Homepage.last
  end
end

shared_steps "edit homepage" do
  perform_steps "sign in with"

  it "should should have Sign Out" do
    expect(page).to have_content("Sign Out")
  end

  it "visit root" do
    visit "/"
  end

  it "clicks on Edit" do
    click_on("Edit This Page")
  end
end

steps "views homepage to edit" do
  perform_steps "Setup for homepage"

  perform_steps "sign in with"

  it "should have Sign Out" do
    expect(page).to have_content("Sign Out")
  end

  it "visit root" do
    visit "/"
  end

  it "should have correct content" do
    expect(page).to have_title(@homepage.title)
    expect(page).to have_content(@homepage.contents["headline"])
    expect(page).to have_content(@homepage.contents["main"])
    expect(page).to have_button("Edit This Page")
  end

  it "click on edit" do
    click_on("Edit This Page")
  end
end

steps "title" do
  perform_steps "Setup for homepage"
  perform_steps "edit homepage"

  it "enter new title" do
    fill_in "Title", :with => "Brand New Homepage Title"
  end

  it "save" do
    click_on("Save")
  end

  it "persist correctly" do
    expect(page).to have_css("#root_homepage_show")
    expect(page.title).to include("Brand New Homepage Title")
  end
end

steps "keywords" do
  perform_steps "Setup for homepage"
  perform_steps "edit homepage"

  it "enter new keywords" do
    fill_in "Keywords", :with => "this, that, the other thing"
  end

  it "save" do
    click_on("Save")
  end

  it "have correct metadata" do
    expect(page).to have_css("#root_homepage_show")
    meta_content = find(:xpath, "//meta[@name='keywords']", :visible => false)[:content]
    expect(meta_content).to eq("this, that, the other thing")
  end
end

steps "description" do
  perform_steps "Setup for homepage"
  perform_steps "edit homepage"

  it "enter new description" do
    fill_in "Description", :with => "Question your tea spoons."
  end

  it "save" do
    click_on("Save")
  end

  it "should have correct content" do
    expect(page).to have_css("#root_homepage_show")
    meta_content = find(:xpath, "//meta[@name='description']", :visible => false)[:content]
    expect(meta_content).to eq("Question your tea spoons.")
  end
end

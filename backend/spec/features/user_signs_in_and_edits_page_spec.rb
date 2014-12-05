require 'spec_helper'


shared_steps "editing a page" do
  perform_steps "sign in with"

  it "clicks on Edit Page" do
    click_on("Edit Page")
  end

  it "clicks on page title" do
    within "#root_admin_pages" do
      click_on(@oc_page.title)
    end
  end

  it "clicks on Edit This Page" do
    click_on("Edit This Page")
  end
end

steps "User views a page to edit", :type => :feature do
  before :all do
    @user = FactoryGirl.create(:confirmed_user)
    @oc_page = FactoryGirl.create(:one_column_page)
  end

  perform_steps "sign in with"

  it "should have 'Edit Page'" do
    expect(page).to have_content("Edit Page")
  end

  it "clicks on Edit Page" do
    click_on("Edit Page")
  end

  it "should click on the page title" do
    within "#root_admin_pages" do
      click_on(@oc_page.title)
    end
  end

  it "should have the correct content" do
    expect(page).to have_title(@oc_page.title)
    expect(URI(current_url).fragment).to eq("/pages/"+ @oc_page.url_slug)
    expect(page.body).to include(@oc_page.contents["headline"].body)
    expect(page.body).to include(@oc_page.contents["main"].body)
    expect(page).to have_content("Edit This Page")
  end
end

steps "edits and saves page content blocks" do
  before :all do
    @user = FactoryGirl.create(:confirmed_user)
    @oc_page = FactoryGirl.create(:one_column_page)
  end

  perform_steps "editing a page"

  it "should edit correctly" do
    expect(page).to have_css("*[lrd-admin-editable='headline']")
    page.all('.froala-element')[0].set("Brand New Headline")
    expect(page).to have_css("*[lrd-admin-editable='main']")
    page.all('.froala-element')[1].set("Spanking new content!")
  end

  it "should save the page" do
    click_on("Save")
  end

  it "should save correctly" do
    expect(page).to have_css("#root_inner_page_show")
    expect(page).to have_content("Brand New Headline")
    expect(page).to have_content("Spanking new content!")
  end
end

steps "edits and saves a page's title" do
  before :all do
    @user = FactoryGirl.create(:confirmed_user)
    @oc_page = FactoryGirl.create(:one_column_page)
  end

  perform_steps "editing a page"

  it "change the title" do
    fill_in "Title", :with => "Brand New Title"
  end

  it "click Save" do
    click_on("Save")
  end

  it "should persist the Title" do
    expect(page).to have_css("#root_inner_page_show")
    expect(page.title).to include("Brand New Title")
  end
end

steps "edits and saves a page's url_slug" do
  before :all do
    @user = FactoryGirl.create(:confirmed_user)
    @oc_page = FactoryGirl.create(:one_column_page)
  end

  perform_steps "editing a page"

  it "changes the Slug" do
    fill_in "URL Slug / Permalink", :with => "new_slug"
  end

  it "Saves" do
    click_on("Save")
  end

  it "should persist correctly" do
    expect(page).to have_css("#root_inner_page_show")
    expect(URI(current_url).fragment).to eq("/pages/new_slug")
  end
end

steps "edits and saves a page's keywords" do
  before :all do
    @user = FactoryGirl.create(:confirmed_user)
    @oc_page = FactoryGirl.create(:one_column_page)
  end

  perform_steps "editing a page"

  it "change the Keywords" do
    fill_in "Keywords", :with => "this, that, the other thing"
  end

  it "Saves" do
    click_on("Save")
  end

  it "should change the meta data" do
    expect(page).to have_css("#root_inner_page_show")

    meta_content = find(:xpath, "//meta[@name='keywords']", :visible => false)[:content]
    expect(meta_content).to eq("this, that, the other thing")
  end
end


steps "edits and saves a page's description" do
  before :all do
    @user = FactoryGirl.create(:confirmed_user)
    @oc_page = FactoryGirl.create(:one_column_page)
  end

  perform_steps "editing a page"

  it "changes the description" do
    fill_in "Description", :with => "Question your tea spoons."
  end

  it "Saves" do
    click_on("Save")
  end

  it "should change the description" do
    expect(page).to have_css("#root_inner_page_show")

    meta_content = find(:xpath, "//meta[@name='description']", :visible => false)[:content]
    expect(meta_content).to eq("Question your tea spoons.")
  end
end

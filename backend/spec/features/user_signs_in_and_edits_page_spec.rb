require 'spec_helper'

feature "User Signs In and Edits Page", :js => true, :vcr => {} do

  let! :user do
    FactoryGirl.create(:confirmed_user)
  end

  let! :oc_page do
    FactoryGirl.create(:one_column_page)
  end

  def edit_page(page)
    sign_in_with(user.email, user.password)
    click_on("Edit Page")
    within "#root_admin_pages" do
      click_on(page.title)
    end
    click_on("Edit This Page")
  end

  scenario "views a page to edit" do
    sign_in_with(user.email, user.password)
    expect(page).to have_content("Edit Page")
    click_on("Edit Page")
    within "#root_admin_pages" do
      expect(page).to have_content(oc_page.title)
      click_on(oc_page.title)
    end
    expect(page).to have_title(oc_page.title)
    expect(URI(current_url).fragment).to eq("/pages/"+ oc_page.url_slug)
    expect(page.body).to include(oc_page.contents["headline"].body)
    expect(page.body).to include(oc_page.contents["main"].body)
    expect(page).to have_content("Edit This Page")
  end

  scenario "edits and saves page content blocks" do
    edit_page(oc_page)
    expect(page).to have_css("*[lrd-admin-editable='headline']")
    page.all('.froala-element')[0].set("Brand New Headline")
    expect(page).to have_css("*[lrd-admin-editable='main']")
    page.all('.froala-element')[1].set("Spanking new content!")
    click_on("Save")
    expect(page).to have_css("#root_inner_page_show")
    expect(page).to have_content("Brand New Headline")
    expect(page).to have_content("Spanking new content!")
  end

  scenario "edits and saves a page's title" do
    edit_page(oc_page)
    fill_in "Title", :with => "Brand New Title"
    click_on("Save")
    expect(page).to have_css("#root_inner_page_show")
    expect(page.title).to include("Brand New Title")
  end

  scenario "edits and saves a page's url_slug" do
    edit_page(oc_page)
    fill_in "URL Slug / Permalink", :with => "new_slug"
    click_on("Save")
    expect(page).to have_css("#root_inner_page_show")
    expect(URI(current_url).fragment).to eq("/pages/new_slug")
  end

  scenario "edits and saves a page's keywords" do
    edit_page(oc_page)
    fill_in "Keywords", :with => "this, that, the other thing"
    click_on("Save")
    expect(page).to have_css("#root_inner_page_show")

    meta_content = find(:xpath, "//meta[@name='keywords']", :visible => false)[:content]
    expect(meta_content).to eq("this, that, the other thing")
  end

  scenario "edits and saves a page's description" do
    edit_page(oc_page)
    fill_in "Description", :with => "Question your tea spoons."
    click_on("Save")
    expect(page).to have_css("#root_inner_page_show")

    meta_content = find(:xpath, "//meta[@name='description']", :visible => false)[:content]
    expect(meta_content).to eq("Question your tea spoons.")
  end
end

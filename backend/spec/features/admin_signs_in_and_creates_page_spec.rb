require 'spec_helper'

feature "User Signs In and Edits Page", :js => true, :vcr => {} do

  let! :user do
    FactoryGirl.create(:confirmed_user)
  end

  let! :oc_page do
    FactoryGirl.create(:one_column_page)
  end

  scenario "creates a new one-column page" do
    sign_in_with(user.email, user.password)
    click_on "Edit Pages"
    click_on "Create A New Page"
    select "One Column", :from => "Choose a layout for your page"
    click_on "Go"

    fill_in "Title", :with => "Page Title"
    fill_in "Keywords", :with => "this, that, the other thing"
    fill_in "Description", :with => "Question your tea spoons."


    page.all('.froala-element')[0].set("Brand New Headline")
    page.all('.froala-element')[1].set("Spanking new content!")
    click_on "Save"

    expect(page).to have_css("#root_inner_page_show")
    expect(page).to have_content("Brand New Headline")
    expect(page).to have_content("Spanking new content!")
  end

end

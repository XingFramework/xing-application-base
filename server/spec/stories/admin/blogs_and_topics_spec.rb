require 'spec_helper'

steps "Admin manages blog posts", :type => :feature, :js => true do
  include TinyMCETools

  it "should load the login page" do
    visit '/login'
  end

  it "when the admin logs in" do
    fill_in("user_login", :with => "admin")
    fill_in("user_password", :with => "wxyz")
    click_button("Login")
  end

  it "should visit the Edit Topics page" do
    #click_link "Edit Blog Topics"
    visit admin_topics_path #TODO Does this client need a blog?
  end

  it "should should create a new Topic" do
    click_link "New Topic"
  end

  it "should fill in settings for the Topic" do
    fill_in "Name", :with => "Bookkeeping"

    click_button "Save Topic"
  end

  it "should should create a new Topic" do
    click_link "New Topic"
  end

  it "should fill in settings for the Topic" do
    fill_in "Name", :with => "Record Keeping"

    click_button "Save Topic"
  end

  it "should visit the Edit Blogs page" do
    #click_link "Edit Blog Posts"
    visit admin_blog_posts_path #TODO Does this client need a blog
  end

  it "should create a new blog post" do
    click_link "New Blog Post"
  end

  it "should fill in some content and select a topic" do
    fill_in "Title",        :with => "A New Blog Post"
    fill_in "Permalink",        :with => "first-post"
    fill_in_tinymce "page_content", :with => "Judson is 29 and Evan is not telling"
    select "Bookkeeping", :from => "Topic"
    click_button "Save Blog Post"
  end

  it "should visit the post" do
    visit "/first-post"
#    visit root_path
#    within "#blog" do
#      click_link "A New Blog Post"
#    end
  end

  it "should have the content" do
    page.should have_content "Judson is 29"
  end

  it "should visit the blogs section" do
    visit topics_path
#    visit root_path
#    within("#blog") do
#      click_link "Read More..."
#    end
  end

  it "should find the content in the blogs list" do
    page.should have_content "Judson is 29"
  end

  it "should visit the topic" do
    click_link "Bookkeeping"
  end

  it "should see the blog post under that topic" do
    page.should have_content "Judson is 29"
  end

  it "should proceed to the post" do
    click_link "Full text..."
    page.should have_content "Judson is 29"
  end

  it "should return to the Edit Blogs tool" do
    #click_link "Edit Blog Posts"
    visit admin_blog_posts_path #TODO Does this client need a blog

    within(:xpath, "//tr[.//a[@href='/first-post']]") do
      click_link "Edit"
    end
  end

  it "should change the blog topic" do
    select "Record Keeping", :from => "Topic"
    click_button "Save Blog Post"
  end

  it "in the blogs section" do
    visit topics_path
#    visit root_path
#    within("#blog") do
#      click_link "Read More..."
#    end
  end

  it "should visit the old topic" do
    click_link "Bookkeeping"
  end

  it "should not see the blog post" do
    page.should_not have_content "Judson is 29"
  end

  it "from the blogs section" do
    visit topics_path
#    visit root_path
#    within("#blog") do
#      click_link "Read More..."
#    end
  end

  it "should visit the new topic" do
    click_link "Record Keeping"
  end

  it "should see the blog post there" do
    page.should have_content "Judson is 29"
  end
end

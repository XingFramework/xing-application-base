
steps "User Signs In and Creates a new Page", :js => true, :vcr => {}, :type => 'feature' do

  let! :user do
    FactoryGirl.create(:confirmed_user)
  end

  let! :oc_page do
    FactoryGirl.create(:one_column_page)
  end

  perform_steps "visit login"

  it "should sign in" do |example|
    #byebug
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password

    p :factoried_user => user
    p :database_user => User.where(:email => user.email).first
    byebug

    click_button "Sign In"
  end

  it "should click edit pages" do
    #byebug
    click_on "Edit Pages"
  end

  it "should click Create Page" do
    #byebug
    click_on "Create A New Page"
  end

  it "should select a layout" do
    select "One Column", :from => "Choose a layout for your page"
  end

  it "should start editing new page" do
    click_on "Go"
  end

  it "should have correct placeholders" do
    expect(page).to have_xpath("//*[@placeholder='Add content for headline here']", :visible => false)
    expect(page).to have_xpath("//*[@placeholder='Add content for main here']", :visible => false)
  end

  it "should fill in metadata" do
    fill_in "Title", :with => "Page Title"
    fill_in "Keywords", :with => "this, that, the other thing"
    fill_in "Description", :with => "Question your tea spoons."
  end

  it "should fill in content" do
    page.all('.froala-element')[0].set("Brand New Headline")
    page.all('.froala-element')[1].set("Spanking new content!")
  end

  it "should save the page" do
    click_on "Save"
  end

  it "should have the edited content" do
    expect(page).to have_css("#root_inner_page_show")
    expect(page).to have_content("Brand New Headline")
    expect(page).to have_content("Spanking new content!")
  end
end

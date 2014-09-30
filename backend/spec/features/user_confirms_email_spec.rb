require 'spec_helper'

steps "User confirms email", :type => :feature, :js => true, :vcr => {} do


  before :all do
    u = User.create!(:email => "joe@joesponsor.com",
      :email_confirmation => "joe@joesponsor.com",
      :password => TEST_PASSWORD,
      :password_confirmation => TEST_PASSWORD)
    u.send_confirmation_instructions({redirect_url: "/#/"})
    email = open_email('joe@joesponsor.com')
    email.click_link('Confirm my account')
    visit '/'
    click_on "Sign In"
    fill_in "Email", :with => 'joe@joesponsor.com'
    fill_in "Password", :with => TEST_PASSWORD
    click_button "Sign In"
  end

  it "when I confirm and sign in, should send me to the login success page" do
     URI.parse(current_url).request_uri.should == '#/login_success'
     page.should have_content("You have successfully logged in!")
  end

end

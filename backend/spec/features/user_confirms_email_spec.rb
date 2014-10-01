require 'spec_helper'

feature "User confirms email", :js => true, :vcr => {} do


  background do
    u = User.create!(:email => "joe@joehomebuyer.com",
      :email_confirmation => "joe@joehomebuyer.com",
      :password => TEST_PASSWORD,
      :password_confirmation => TEST_PASSWORD)
    u.send_confirmation_instructions({redirect_url: "/#/"})
    email = open_email('joe@joehomebuyer.com')
    email.click_link('Confirm my account')
  end

  scenario "sign in after confirming email" do
    sign_in_with('joe@joehomebuyer.com', TEST_PASSWORD)

    expect(page).to have_content("Sign Out")
  end

end

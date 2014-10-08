require 'spec_helper'

feature "User Signs Up", :js => true, :vcr => {} do

  def confirm_user
    User.last.confirm!
  end

  scenario "confirmation sent" do
    sign_up_with('joe@joehomebuyer.com', TEST_PASSWORD)
    expect(page).to have_content("confirmation link")
    expect(ActionMailer::Base.deliveries).to_not be_empty
    email = open_email('joe@joehomebuyer.com')
    email.should have_link('Confirm my account')
  end

  scenario "sign up then sign in" do
    sign_up_with('joe@joehomebuyer.com', TEST_PASSWORD)
    confirm_user
    sign_in_with('joe@joehomebuyer.com', TEST_PASSWORD)
    expect(page).to have_content("Sign Out")
  end

end

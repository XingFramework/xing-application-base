require 'spec_helper'

feature "User Sends Reset Password", :js => true, :vcr => {} do
  background do
    @user = FactoryGirl.create(:confirmed_user)
  end

  scenario "login page has reset password link" do
    visit_login
    page.should have_content("Forgot your password?")
  end

  scenario "send forgot password email" do
    visit_login
    click_on("Forgot your password?")
    fill_in "Email", :with => @user.email
    click_on("Send password reset instructions")
    page.should have_content("You will receive an email with instructions on how to reset your password in a few minutes.")
    email = open_email(@user.email)
    email.should have_link("Change my password")
  end

end

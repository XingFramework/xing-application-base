require 'spec_helper'

steps "User Sends Reset Password", :js => true, :vcr => {} do
  before :all do
    @user = FactoryGirl.create(:confirmed_user)
  end

  perform_steps "visit login"

  step "click forgot password" do
    click_on("Forgot your password?")
  end

  step "enter email address" do
    fill_in "Email", :with => @user.email
  end

  step "click send reset" do
    click_on("Send password reset instructions")
  end

  it "should have the confirmation" do
    page.should have_content("You will receive an email with instructions on how to reset your password in a few minutes.")
  end

  it "should send the email" do
    email = open_email(@user.email)
    email.should have_link("Change my password")
  end
end

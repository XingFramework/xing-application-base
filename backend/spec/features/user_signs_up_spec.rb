require 'spec_helper'

steps "User Signs Up", :js => true, :vcr => {} do
  before :all do
    @user = FactoryGirl.build(:user)
  end

  perform_steps "sign up with"

  it "should have confirmation link" do
    expect(page).to have_content("confirmation link")
  end

  it "should send email" do
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it "should have link in email" do
    email = open_email(@user.email)
    expect(email).to have_link('Confirm my account')
  end

  step "confirm user" do
    User.last.confirm
  end

  it "should go to sign in" do
    first(:link, "Sign In").click
  end

  it "should log in" do
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign In"
  end

  it "should have sign out" do
    expect(page).to have_content("Sign Out")
  end
end

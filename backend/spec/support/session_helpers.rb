require 'rspec-steps'

module Features
  module SessionHelpers
    COLLAPSED_MENU_SIZES=[ :mobile, :small ]

    def visit_login
      visit '/'
      expand_menu_if_necessary
      within ".session-links" do
        click_link "Sign In"
      end
    end

    def expand_menu_if_necessary
      # On pages with collapsed menu, click to expand the menu
      # before trying to click the sign-in link.  I'm doing it this
      # way instead of inspecting the page for .session-links because
      # the latter triggers a capybra wait, which is much slower.
      if COLLAPSED_MENU_SIZES.include?(BrowserSize.current_size)
        click_on('Menu')
      end
    end

    def sign_up_with(email, password)
      visit '/'
      expand_menu_if_necessary
      click_on "Sign Up"
      fill_in "Email",           :with => email
      fill_in "Email Confirmation", :with => email
      fill_in "Password",        :with => password
      fill_in "Password Confirmation", :with => password
      click_button "Sign Up"
    end

    def sign_in_with(email, password)
      visit_login
      fill_in "Email", :with => email
      fill_in "Password", :with => password
      click_button "Sign In"
    end
  end
end

RSpec.shared_steps "expand the menu" do
  it "clicks on the menu (if needed)" do
    if Features::SessionHelpers::COLLAPSED_MENU_SIZES.include?(BrowserSize.current_size)
      click_on('Menu')
    end
  end
end

RSpec.shared_steps "visit login" do
  it "visits root" do
    visit '/'
  end

  perform_steps "expand the menu"

  it "clicks on Sign In" do
    within ".session-links" do
      click_link "Sign In"
    end
  end
end

RSpec.shared_steps "sign up with" do
  it "visits root" do
    visit '/'
  end

  peform_steps "expand the menu"

  it "clicks Sign Up" do
    click_on "Sign Up"
  end

  it "fills in #{email} and #{pasword}" do
    fill_in "Email",           :with => @user.email
    fill_in "Email Confirmation", :with => @user.email
    fill_in "Password",        :with => @user.password
    fill_in "Password Confirmation", :with => @user.password
  end

  it "clicks Sign Up" do
    click_button "Sign Up"
  end
end

RSpec.shared_steps "sign in with" do
  perform_steps "visit login"

  it "fills in email and password" do
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
  end

  it "clicks Sign In" do
    click_button "Sign In"
  end
end

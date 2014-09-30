module Features
  module SessionHelpers

    def sign_up_with(email, password)
      visit '/'
      click_on "Sign Up"
      fill_in "Email",           :with => email
      fill_in "Email confirmation", :with => email
      fill_in "Password",        :with => password
      fill_in "Password confirmation", :with => password
      click_on "Submit"
    end

    def sign_in_with(email, password)
      visit '/'
      click_on "Sign In"
      fill_in "Email", :with => email
      fill_in "Password", :with => password
      click_button "Sign In"
    end
  end
end

module Features
  module SessionHelpers

    def sign_up_with(email, password)
      visit '/'
      click_on "Sign Up"
      fill_in "Email",           :with => email
      fill_in "Email Confirmation", :with => email
      fill_in "Password",        :with => password
      fill_in "Password Confirmation", :with => password
      click_button "Sign Up"
    end

    def sign_in_with(email, password)
      visit '/'
      within ".session-links" do
        click_link "Sign In"
      end
      fill_in "Email", :with => email
      fill_in "Password", :with => password
      click_button "Sign In"
    end
  end
end

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

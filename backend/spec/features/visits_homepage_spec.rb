require 'spec_helper'

feature "Visitor loads the homepage", :js => true, :vcr => {} do

  scenario  do
    visit '/'
    expect(page).to have_content("whatever")
  end

end

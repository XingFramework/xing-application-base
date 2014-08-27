require 'spec_helper'

describe "/admin/pages/edit" do

  let :page do FactoryGirl.create(:page) end
  before do
    assign(:page, page)
    render
  end


  it "should render" do
    rendered.should have_css("form[action='#{admin_page_path(page)}'][method=post]")
  end
  it "should have a css block in a collapsed div" do
    rendered.should have_css("form[action='#{admin_page_path(page)}'][method=post]") do |scope|
      scope.should have_css("div[class=collapsed]")
      scope.should have_css("textarea[name='page[css]']")
    end
  end

end



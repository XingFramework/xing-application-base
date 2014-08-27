require 'spec_helper'

describe "/admin/pages/new" do

  before(:each) do
    assign(:page, Page.new())
  end

  it "should succeed" do
    render
  end

  it "should render new form" do
    render
    rendered.should have_selector("form[action='#{admin_pages_path}'][method=post]")
  end
end



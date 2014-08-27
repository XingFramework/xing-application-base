require 'spec_helper'

describe "/admin/images/index" do
  before(:each) do
    assign(:images, [ FactoryGirl.create(:image), FactoryGirl.create(:image) ])
  end

  it "should succeed" do
    render
  end

  it "should show an image in the list view" do
    render
    rendered.should have_selector("td img")
  end
end


require 'spec_helper'

describe "/admin/pages/index" do

  before(:each) do
    assign(:pages, [ FactoryGirl.create(:page), FactoryGirl.create(:page) ])
  end

  it "should succeed" do
    render
  end
end


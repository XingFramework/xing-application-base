require 'spec_helper'

describe "/admin/images/show" do
  before(:each) do
    assign(:image, @image = FactoryGirl.build(:image))
  end

  it "should succeed" do
    render
  end
end


require 'spec_helper'

describe "/admin/documents/show" do
  before(:each) do
    assign(:document, @document = FactoryGirl.build(:document))
  end

  it "should succeed" do
    render
  end
end


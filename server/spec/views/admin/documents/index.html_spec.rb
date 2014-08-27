require 'spec_helper'

describe "/admin/documents/index" do
  before(:each) do
    assign(:documents, [ FactoryGirl.create(:document), FactoryGirl.create(:document) ])
  end

  it "should succeed" do
    render
  end
end


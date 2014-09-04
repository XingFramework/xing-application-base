require 'spec_helper'

describe Page::OneColumn do

  let :page do
    FactoryGirl.create(:one_column_page)
  end

  it "should be a page" do
    expect(page).to be_a(Page)
  end

  it "should appear in the registry" do
    Page.registry_get(:one_column).should == Page::OneColumn
  end
end

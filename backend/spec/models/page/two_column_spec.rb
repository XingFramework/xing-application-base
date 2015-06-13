require 'spec_helper'

describe Page::TwoColumn do

  let :page do
    FactoryGirl.create(:two_column_page)
  end

  it "should be a page" do
    expect(page).to be_a(Page)
  end

  it "should have four blocks in its content" do
    expect(page.contents.keys.length).to eq(4)
  end

  it "should have the correct layout" do
    expect(page.layout).to eq("two_column")
  end
  it "should have columns called column_one and column_two" do
    expect(page.content_format.map(&:first).map(&:last)).to include('column_one', 'column_two')
  end

  it "should appear in the registry" do
    expect(Page.registry_get(:two_column)).to eq(Page::TwoColumn)
  end
end

require 'spec_helper'

describe Page::Homepage do

  it "should have one created by seeds.rb" do
    expect(Page::Homepage.get).to be_a(Page::Homepage)
    expect(Page::Homepage.get).to be_persisted
    expect(Page::Homepage.get.url_slug).to eq('homepage')
  end


  it "should not allow two homepages to be created in the DB" do
    expect(Page::Homepage.new(:url_slug => 'homepage2')).not_to be_valid
  end

  it "should not allow permalink to be changed" do
    page = Page::Homepage.get
    page.url_slug = 'something_else'
    expect(page).not_to be_valid
  end

end

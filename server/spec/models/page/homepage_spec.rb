require 'spec_helper'

describe Page::Homepage do

  it "should have one created by seeds.rb" do
    expect(Page::Homepage.new).to be_a(Page::Homepage)
    expect(Page::Homepage.new).to be_persisted
  end


  it "should not allow two homepages to be created in the DB"

  it "should not allow permalink to be changed"

end

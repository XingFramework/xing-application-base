# == Schema Information
#
# Table name: pages
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  published        :boolean          default(TRUE), not null
#  keywords         :text
#  description      :text
#  edited_at        :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  layout           :string(255)
#  publish_start    :datetime
#  publish_end      :datetime
#  metadata         :hstore
#  url_slug         :string(255)
#  publication_date :datetime
#

require 'spec_helper'

describe Page, :pending => "Awaiting implementation in CMS2" do
  describe "mass assignment" do
    it "should mass assign title and permalink" do
      page = Page.new(:title => 'foo', :permalink => 'bar' )
      page.title.should == 'foo'
      page.permalink.should == 'bar'
    end

    it "should mass assign css" do
      page = Page.new(:css => 'body { color :black }')
      page.css.should == 'body { color :black }'
    end
  end

  describe "validations" do
    describe "uniqueness" do
      it "should not create two pages with the same title" do
        page_1 = FactoryGirl.create(:page, :title => 'foo')
        page_2 = FactoryGirl.build(:page, :title => 'foo')
        page_2.should_not be_valid
      end
      it "should not create two pages with the same permalink" do
        page_1 = FactoryGirl.create(:page, :permalink => 'foo')
        page_2 = FactoryGirl.build(:page, :permalink => 'foo')
        page_2.should_not be_valid
      end
    end
  end

  describe "published scope" do
    before :each do
      @page_1 = FactoryGirl.create(:page, :published => true)
      @page_2 = FactoryGirl.build(:page, :published => false)
    end
    it "should include a published page" do
      Page.published.should include @page_1
    end
    it "should not include an unpublished page" do
      Page.published.should_not include @page_2
    end
  end
end

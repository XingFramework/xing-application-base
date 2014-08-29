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

describe Page do
  describe "mass assignment", :pending => true do
    it "should mass assign title and permalink" do
      page = Page.new(:title => 'foo', :peink => 'bar' )
      page.title.should == 'foo'
      page.permalink.should == 'bar'
    end
  end

  describe "contents" do
    let :contents do
      page.contents
    end

    describe "with a page that has two blocks" do
      let :page do
        FactoryGirl.create(:one_column_page)
      end

      it "should return a hash of ContentBlocks with headline and body" do
        contents.should be_a(Hash)
      end
    end
  end

  describe "validations", :pending => 'awaiting implementation' do
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

  describe "published scope", :pending => 'awaiting implementation' do
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

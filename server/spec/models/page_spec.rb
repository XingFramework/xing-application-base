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

  describe "contents" do
    let :contents do
      page.contents
    end

    describe "with a page that has two blocks" do
      let :page do
        FactoryGirl.create(:one_column_page)
      end

      it "should return a hash of ContentBlocks with headline and body" do
        expect(contents).to be_a(Hash)
        expect(contents.length).to eq(2)
        expect(contents['headline']).to be_a(ContentBlock)
        expect(contents['main']).to be_a(ContentBlock)
      end
    end

    describe "when content_format is present" do
      before do
        Page.stub!(:content_format).and_return(format)
      end

      let :format do
        [{ :name         => 'headline',
           :content_type => 'text/html'
        },
        {  :name         => 'main',
           :content_type => 'text/html'
        }]
      end

      let! :page do
        FactoryGirl.create(:one_column_page)
      end
      let! :headline do FactoryGirl.create(:content_block) end
      let! :main     do FactoryGirl.create(:content_block) end
      let! :foo      do FactoryGirl.create(:content_block) end
      let! :bar      do FactoryGirl.create(:content_block) end

      before do
        page.page_contents =[  PageContent.new(:name => 'headline', :content_block => headline),
                               PageContent.new(:name => 'main', :content_block => main),
                               PageContent.new(:name => 'foo', :content_block => foo),
                               PageContent.new(:name => 'bar', :content_block => bar)
        ]
        page.save!
      end

      it "should return only the included blocks" do
        expect(contents).to have_key('headline')
        expect(contents).to have_key('main')
        expect(contents).not_to have_key('foo')
        expect(contents).not_to have_key('bar')
      end
    end
  end


  describe "validations" do
    describe "uniqueness" do
      it "should not create two pages with the same url slug" do
        FactoryGirl.create(:one_column_page,  :url_slug => 'foo')
        expect(
          FactoryGirl.build(:one_column_page, :url_slug => 'foo')
        ).not_to be_valid
      end
    end
  end

  describe "published scope", :pending => "decide exactly which published parameters we need" do
    let! :published_page   do FactoryGirl.create(:one_column_page, :published => true)  end
    let! :unpublished_page do FactoryGirl.create(:one_column_page, :published => false) end

    it "should include a published page but not unpublished page" do
      expect(Page.published).to include(published_page)
    end
    it "should not include an unpublished page" do
      expect(Page.published).not_to include(unpublished_page)
    end
  end
end

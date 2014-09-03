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
        Page.stub(:content_format).and_return(format)
      end

      let :format do
        [{ :name         => 'headline',
           :content_type => 'text/html'
        },
        {  :name         => 'main',
           :content_type => 'text/html'
        },
        {  :name         => 'css',
           :content_type => 'text/css'
        }]
      end

      let! :page do
        FactoryGirl.create(:one_column_page)
      end
      let! :headline do FactoryGirl.create(:content_block, :body => 'the content') end
      let! :main     do FactoryGirl.create(:content_block) end
      let! :foo      do FactoryGirl.create(:content_block) end
      let! :bar      do FactoryGirl.create(:content_block) end
      let! :css      do FactoryGirl.create(:content_block, :content_type => 'text/css', :body => "uncleaned") end

      before do
        page.page_contents =[  PageContent.new(:name => 'headline', :content_block => headline),
                               PageContent.new(:name => 'main', :content_block => main),
                               PageContent.new(:name => 'css', :content_block => css),
                               PageContent.new(:name => 'foo', :content_block => foo),
                               PageContent.new(:name => 'bar', :content_block => bar)
        ]
        page.save!
      end

      it "should return only the included blocks" do
        expect(contents).to     have_key('headline')
        expect(contents).to     have_key('main')
        expect(contents).to     have_key('css')
        expect(contents).not_to have_key('foo')
        expect(contents).not_to have_key('bar')
      end

      describe "and includes a sanitization specifier" do
        let :format do
          [{ :name          => 'headline',
             :content_type  => 'text/html',
             :sanitize_with => :clean_this_thing
          },
          {  :name         => 'main',
             :content_type => 'text/html'
          }]
        end
        it "should use the validator for that content body" do
          page.should_receive(:clean_this_thing).and_return('cleaned content')
          expect(contents['headline'].body).to eq('cleaned content')
        end
      end

      describe "And no sanitizer is specified for an HTML block" do
        let :format do
          [{ :name          => 'headline',
             :content_type  => 'text/html',
          }]
        end
        it "should use the default validator for html" do
          page.should_receive(:sanitize_html).with(headline.body).and_return('cleaned content')
          expect(contents['headline'].body).to eq('cleaned content')
        end
      end

      describe "And no sanitizer is specified for a CSS block" do
        let :format do
          [{ :name          => 'css',
             :content_type  => 'text/css'
          }]
        end
        it "should use the default validator for css" do
          page.should_receive(:sanitize_css).with(css.body).and_return('.clean { white-space: nowrap; } ')
          expect(contents['css'].body).to eq('.clean { white-space: nowrap; } ')
        end
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

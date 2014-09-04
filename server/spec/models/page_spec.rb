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
    let :headline do FactoryGirl.create(:content_block, :body => 'the content') end
    let :main     do FactoryGirl.create(:content_block) end
    let :foo      do FactoryGirl.create(:content_block) end
    let :bar      do FactoryGirl.create(:content_block) end
    let :styles   do FactoryGirl.create(:content_block, :content_type => 'text/css', :body => "uncleaned") end

    let :contents do
      page.contents
    end

    describe "with a page that has two blocks" do
      let :page do
        FactoryGirl.create(:page,
          :page_contents => [  PageContent.new(:name => 'headline', :content_block => headline),
                               PageContent.new(:name => 'main', :content_block => main)]
        )
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
        {  :name         => 'styles',
           :content_type => 'text/css'
        }]
      end

      let! :page do
        FactoryGirl.create(:page)
      end

      before do
        page.page_contents =[  PageContent.new(:name => 'headline', :content_block => headline),
                               PageContent.new(:name => 'main', :content_block => main),
                               PageContent.new(:name => 'styles', :content_block => styles),
                               PageContent.new(:name => 'foo', :content_block => foo),
                               PageContent.new(:name => 'bar', :content_block => bar)
        ]
        page.save!
      end

      it "should return only the included blocks" do
        expect(contents).to     have_key('headline')
        expect(contents).to     have_key('main')
        expect(contents).to     have_key('styles')
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
          [{ :name          => 'styles',
             :content_type  => 'text/css'
          }]
        end
        it "should use the default validator for css" do
          page.should_receive(:sanitize_css).with(styles.body).and_return('.clean { white-space: nowrap; } ')
          expect(contents['styles'].body).to eq('.clean { white-space: nowrap; } ')
        end
      end
    end
  end

  describe "set_url_slug" do
    describe "when manually set" do
      it "should not change the slug" do
        page = FactoryGirl.build(:page, :url_slug => 'this-is-a-test')
        expect do
          page.set_url_slug
        end.not_to change{page.url_slug}
      end
    end

    describe "when not set" do
      describe "when title is set" do

        it "should create it based on the title" do
          page = FactoryGirl.build(:page, :url_slug => nil, :title => "The Gettysburgh Address")
          expect do
            page.set_url_slug
          end.to change{page.url_slug}.from(nil).to('the-gettysburgh-address')
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

  describe 'registry' do
    before do
      class Page::TestPage < Page
      end

      class Page::SubTestPage < Page::TestPage
      end
    end

    after do
      Page.registry.delete('test_page')
    end

    it 'should allow registration of page subclasses' do
      Page::TestPage.register('test_page')
      Page.registry['test_page'].should == Page::TestPage
    end

    it "registers sub pages" do
      Page::TestPage.register('test_page')
      Page::SubTestPage.register('sub_test_page')
      Page.registry['sub_test_page'].should == Page::SubTestPage
    end

  end
end

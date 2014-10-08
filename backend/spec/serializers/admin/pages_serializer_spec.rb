require 'spec_helper'

describe Admin::PageSerializer, :type => :serializer do
  let :main     do FactoryGirl.create(:content_block) end
  let :headline do FactoryGirl.create(:content_block, :body => 'the content') end
  let :styles   do FactoryGirl.create(:content_block, :content_type => 'text/css', :body => "uncleaned") end

  def make_page
    FactoryGirl.create(:page, :pre_published,
      :page_contents => [  PageContent.new(:name => 'main', :content_block => main),
                           PageContent.new(:name => 'headline', :content_block => headline),
                           PageContent.new(:name => 'styles', :content_block => styles)]
    )
  end

  let :pages do
    [ make_page, make_page, make_page ]
  end

  describe 'as_json' do
    let :json do
      Admin::PagesSerializer.new(pages).to_json
    end

    it "should have the correct structure" do
      expect(json).to have_json_path('links/self')

    #{ links: {
        #self:   '/admin/pages/:slug1'
        #public: '/pages/:slug1'
      #},
      #data:  {
        #title: 'Page 1',
        #layout: "one_column",
        #url_slug: "url_slug",
        #published: [true | false],
        #publish_start: <date/time>,
        #publish_end: <date/time>
      #}
    #},
      expect(json).to have_json_path('data/0/links/self')
      expect(json).to have_json_path('data/0/data/title')
      expect(json).to have_json_path('data/0/data/layout')
      expect(json).to have_json_path('data/0/data/url_slug')
      expect(json).to have_json_path('data/0/data/published')
      expect(json).to have_json_path('data/0/data/publish_start')
      expect(json).to have_json_path('data/0/data/publish_end')
      expect(json).to have_json_size(3).at_path('data')
    end
  end
end

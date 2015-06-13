require 'spec_helper'

describe Admin::PageSerializer, :type => :serializer do
  let :main     do FactoryGirl.create(:content_block) end
  let :headline do FactoryGirl.create(:content_block, :body => 'the content') end
  let :styles   do FactoryGirl.create(:content_block, :content_type => 'text/css', :body => "uncleaned") end

  let :page do
    FactoryGirl.create(:page, :pre_published,
      :page_contents => [  PageContent.new(:name => 'main', :content_block => main),
                           PageContent.new(:name => 'headline', :content_block => headline),
                           PageContent.new(:name => 'styles', :content_block => styles)]
    )
  end

  describe 'as_json' do
    subject :json do
      Admin::PageSerializer.new(page).to_json
    end

    it { expect(json).to be_present}
    it { is_expected.to have_json_path('links/self')}
    it { is_expected.to have_json_path('links/public')}
    it { is_expected.to have_json_path('data/title')}
    it { is_expected.to have_json_path('data/keywords')}
    it { is_expected.to have_json_path('data/description')}
    it { is_expected.to have_json_path('data/layout')}
    it { is_expected.to have_json_path('data/url_slug')}
    it { is_expected.to have_json_path('data/published')}
    it { is_expected.to have_json_path('data/publish_start')}
    it { is_expected.to have_json_path('data/publish_end')}
    it { is_expected.to have_json_size(3).at_path('data/contents')}
  end
end
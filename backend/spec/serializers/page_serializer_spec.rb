require 'spec_helper'

describe PageSerializer, :type => :serializer do
  let :main     do FactoryGirl.create(:content_block) end
  let :headline do FactoryGirl.create(:content_block, :body => 'the content') end
  let :styles   do FactoryGirl.create(:content_block, :content_type => 'text/css', :body => "uncleaned") end

  let :page do
    FactoryGirl.create(:page,
      :page_contents => [  PageContent.new(:name => 'main', :content_block => main),
                           PageContent.new(:name => 'headline', :content_block => headline),
                           PageContent.new(:name => 'styles', :content_block => styles)]
    )
  end

  describe 'as_json' do
    subject :json do
      PageSerializer.new(page).to_json
    end

    it { should be_present}
    it { should have_json_path('links/self')}
    it { should have_json_path('links/admin')}
    it { should have_json_path('data/title')}
    it { should have_json_path('data/keywords')}
    it { should have_json_path('data/description')}
    it { should have_json_path('data/layout')}
    it { should have_json_size(3).at_path('data/contents')}
  end
end
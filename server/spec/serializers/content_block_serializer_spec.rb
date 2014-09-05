require 'spec_helper'

describe ContentBlockSerializer do
  let :content_block do
    FactoryGirl.create(:content_block)
  end

  describe 'as_json' do
    subject :json do
      ContentBlockSerializer.new(content_block).to_json
    end

    it { should be_present}
    it { should have_json_path('links')}
    it { should have_json_path('data')}
    it { should have_json_size(2).at_path('data')}
    it { should have_json_type(String).at_path('links/self')}
    it { should have_json_type(String).at_path('data/content_type')}
    it { should have_json_type(String).at_path('data/body')}
  end
end
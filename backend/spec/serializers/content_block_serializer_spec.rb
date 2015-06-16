require 'spec_helper'

describe ContentBlockSerializer, :type => :serializer do
  let :content_block do
    FactoryGirl.create(:content_block)
  end

  describe 'as_json' do
    subject :json do
      ContentBlockSerializer.new(content_block).to_json
    end

    it { is_expected.to be_present}
    it { is_expected.to have_json_path('links')}
    it { is_expected.to have_json_path('data')}
    it { is_expected.to have_json_size(2).at_path('data')}
    it { is_expected.to have_json_type(String).at_path('links/self')}
    it { is_expected.to have_json_type(String).at_path('data/content_type')}
    it { is_expected.to have_json_type(String).at_path('data/body')}
  end
end
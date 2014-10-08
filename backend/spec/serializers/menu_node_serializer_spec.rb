require 'spec_helper'

describe MenuNodeSerializer, :type => :serializer do
  let :menu_item_with_page    do FactoryGirl.create(:menu_item_with_page) end
  let :menu_item_without_page do FactoryGirl.create(:menu_item_without_page) end

  let :menu_node do
    mn = double(JsonTreeLister::TreeNode)
    mn.stub(:read_attribute_for_serialization).with(:children) { [] }
    mn
  end

  describe 'as_json' do

    subject :json do
      MenuNodeSerializer.new(menu_node).to_json
    end

    context "for menu item for a page" do
      before do
        menu_node.stub(:node) { menu_item_with_page }
      end

      it { is_expected.to     be_present}
      it { is_expected.to     have_json_path('data/name')}
      it { is_expected.not_to have_json_path('data/path') }
      it { is_expected.to     be_json_eql("\"/pages/#{menu_item_with_page.page.url_slug}\"").at_path('data/page/links/self')}
      it { is_expected.to     have_json_path('data/type')}
      it { is_expected.to     be_json_eql("\"page\"").at_path("data/type")}
      it { is_expected.to     have_json_path('data/children')}
      it { is_expected.to     have_json_type(Array).at_path('data/children')}
    end

    context "for menu item for a link" do
      before do
        menu_node.stub(:node) { menu_item_without_page }
      end

      it { is_expected.to     be_present}
      it { is_expected.to     have_json_path('data/name')}
      it { is_expected.to     have_json_path('data/path') }
      it { is_expected.to     be_json_eql("\"#{menu_item_without_page.path}\"").at_path('data/path')}
      it { is_expected.not_to have_json_path('data/page') }
      it { is_expected.to     have_json_path('data/type')}
      it { is_expected.to     be_json_eql("\"raw_url\"").at_path("data/type")}
      it { is_expected.to     have_json_path('data/children')}
      it { is_expected.to     have_json_type(Array).at_path('data/children')}
    end
  end
end

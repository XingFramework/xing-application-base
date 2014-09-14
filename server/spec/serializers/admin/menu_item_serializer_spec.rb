require 'spec_helper'

describe Admin::MenuItemSerializer do
  let :menu_item_with_page    do FactoryGirl.create(:menu_item_with_page) end
  let :menu_item_without_page do FactoryGirl.create(:menu_item_without_page) end

  describe 'as_json' do
    subject :json do
      Admin::MenuItemSerializer.new(menu_item).to_json
    end

    context "for menu item for a page" do
      let :menu_item do
        menu_item_with_page
      end


      it { is_expected.to     be_present}
      it { is_expected.to     be_json_eql("\"#{routes.admin_menu_item_path(menu_item)}\"").at_path('links/self') }
      it { is_expected.to     have_json_path('data/name')}
      it { is_expected.not_to have_json_path('data/path') }
      it { is_expected.to     be_json_eql("\"#{routes.page_path(menu_item.page)}\"").at_path('data/page/links/self')}
      it { is_expected.to     have_json_path('data/type')}
      it { is_expected.to     be_json_eql("\"page\"").at_path("data/type")}
    end

    context "for menu item for a link" do
      let :menu_item do
        menu_item_without_page
      end

      it { is_expected.to     be_present}
      it { is_expected.to     be_json_eql("\"#{routes.admin_menu_item_path(menu_item)}\"").at_path('links/self') }
      it { is_expected.to     have_json_path('data/name')}
      it { is_expected.to     have_json_path('data/path') }
      it { is_expected.to     be_json_eql("\"#{menu_item.path}\"").at_path('data/path')}
      it { is_expected.not_to have_json_path('data/page') }
      it { is_expected.to     have_json_path('data/type')}
      it { is_expected.to     be_json_eql("\"raw_url\"").at_path("data/type")}
    end
  end
end

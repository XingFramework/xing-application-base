require 'spec_helper'

describe Admin::MenuItemSerializer do
  let :menu_item do
    FactoryGirl.create(:menu_item_with_page)
  end

  describe 'as_json' do
    subject :json do
      Admin::MenuItemSerializer.new(menu_item).to_json
    end

    it { expect(json).to be_present }
    it { should have_json_path('links/self')}
    it { should have_json_path('data/name')}
    it { should have_json_path('data/page_id')}
    it { should have_json_path('data/path')}
    it { should have_json_path('data/parent_id')}
  end
end
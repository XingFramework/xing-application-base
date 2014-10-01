require 'spec_helper'

describe MenuListSerializer do

  before do
    MenuItem.delete_all # get rid of the ones from seeds
  end

  let :menu_1 do
    FactoryGirl.create(:main_menu_root)
  end
  let :menu_2 do
    FactoryGirl.create(:blog_topics_root)
  end

  describe 'as_json' do
    subject :json do
      menu_1
      menu_2
      MenuListSerializer.new(Menu.list).to_json
    end

    it "should have the right JSON structure" do
      expect(json).to have_json_path("links")
      expect(json).to have_json_path("links/self")
      expect(json).to have_json_path("data")

      expect(json).to have_json_path("data/0/data/name")
      expect(json).to have_json_path("data/1/data/name")
      expect(JSON.parse(json)['data'].length).to eq(2)
    end
  end
end

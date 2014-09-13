require 'spec_helper'

describe "pages#show", :type => :request do

  let :menu_item do
    FactoryGirl.create(:menu_item_with_page)
  end

  describe "GET admin/menu_items/:id" do
    it "shows page as json" do
      json_get "admin/menu_items/#{menu_item.id}"

      expect(response).to be_success
      expect(response.body).to have_json_path("links")
      expect(response.body).to have_json_path("links/self")
      expect(response.body).to have_json_path("data")
      expect(response.body).to have_json_path("data/name")
      expect(response.body).to have_json_path("data/path")
      expect(response.body).to have_json_path("data/page_id")
      expect(response.body).to have_json_path("data/parent_id")
      expect(JSON.parse(response.body)["links"]["self"]).to eq("/admin/menu_items/#{menu_item.id}")
      expect(JSON.parse(response.body)["data"]["name"]).to eq(menu_item.name)
      expect(JSON.parse(response.body)["data"]["page_id"]).to eq(menu_item.page.id)
    end
  end
end

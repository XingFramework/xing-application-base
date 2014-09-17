require 'spec_helper'

describe "menu_items#update", :type => :request do

  let! :menu_item do
    FactoryGirl.create(:menu_item)
  end

  let :json_body do
    {
      data: {
        name: 'New Name'
      }
    }.to_json
  end

  describe "PUT admin/menu_items/:id" do
    it "is a 200 success including the serialized object" do

      json_put "admin/menu_items/#{menu_item.id}", json_body

      expect(response).to be_success
      expect(response.body).to     have_json_path("links")
      expect(response.body).to     have_json_path("links/self")
      expect(response.body).to     have_json_path("data")
      expect(response.body).to     have_json_path("data/name")
      expect(response.body).to     have_json_path("data/path")
      expect(response.body).not_to have_json_path("data/page")
      expect(response.body).to     have_json_path("data/parent_id")

      expect(response.body).to be_json_eql("\"#{routes.admin_menu_item_path(menu_item)}\"").at_path('links/self')
      expect(response.body).to be_json_eql("\"New Name\"").at_path("data/name")

    end

    it "should update information" do
      expect do
        json_put "admin/menu_items/#{menu_item.id}", json_body
      end.to change { menu_item.reload.name }.to("New Name")
    end
  end
end

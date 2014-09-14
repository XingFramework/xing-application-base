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
    it "redirects to admin menu item show path" do

      json_put "admin/menu_items/#{menu_item.id}", json_body

      expect(response).to redirect_to( admin_menu_item_path( menu_item ) )
    end

    it "should update information" do
      expect do
        json_put "admin/menu_items/#{menu_item.id}", json_body
      end.to change { menu_item.reload.name }.to("New Name")
    end
  end
end

require 'spec_helper'

describe "admin/menu_items#show", :type => :request do

  let :admin do FactoryGirl.create(:admin) end

  describe "GET admin/menu_items/:id" do

    context "with a menu item that represents a page" do
      let :menu_item do
        FactoryGirl.create(:menu_item_with_page)
      end
      it "generates correct json" do
        authenticated_json_get admin, "admin/menu_items/#{menu_item.id}"

        expect(response).to be_success
        expect(response.body).to     have_json_path("links")
        expect(response.body).to     have_json_path("links/self")
        expect(response.body).to     have_json_path("data")
        expect(response.body).to     have_json_path("data/name")
        expect(response.body).not_to have_json_path("data/path")
        expect(response.body).to     have_json_path("data/parent_id")

        expect(response.body).to be_json_eql("\"#{routes.admin_menu_item_path(menu_item)}\"").at_path('links/self')
        expect(response.body).to be_json_eql("\"#{menu_item.name}\"").at_path("data/name")
      end
    end

    context "with a menu item that reperesents a raw URL" do
      let :menu_item do
        FactoryGirl.create(:menu_item_without_page)
      end

      it "generates correct json" do
        authenticated_json_get admin, "admin/menu_items/#{menu_item.id}"

        expect(response).to be_success
        expect(response.body).to     have_json_path("links")
        expect(response.body).to     have_json_path("links/self")
        expect(response.body).to     have_json_path("data")
        expect(response.body).to     have_json_path("data/name")
        expect(response.body).to     have_json_path("data/path")
        expect(response.body).not_to have_json_path("data/page")
        expect(response.body).to     have_json_path("data/parent_id")

        expect(response.body).to be_json_eql("\"#{routes.admin_menu_item_path(menu_item)}\"").at_path('links/self')
        expect(response.body).to be_json_eql("\"#{menu_item.name}\"").at_path("data/name")
      end
    end


    describe "not authenticated" do
      let :menu_item do
        FactoryGirl.create(:menu_item_with_page)
      end

      it "should return not authorized" do
        json_get "admin/menu_items/#{menu_item.id}"
        expect(response.status).to be(401)
      end

    end
  end
end

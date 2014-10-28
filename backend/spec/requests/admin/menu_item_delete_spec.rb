require 'spec_helper'

describe "menu_items#destroy", :type => :request do

  let! :menu_item do
    FactoryGirl.create(:menu_item)
  end

  let :admin do FactoryGirl.create(:admin) end

  describe "DELETE /admin/menu_items/:id" do
    it "redirects to admin menus path" do

      authenticated_json_delete admin, "admin/menu_items/#{menu_item.id}"

      expect(response).to redirect_to( menus_path )
    end

    it "should delete information" do
      expect do
        authenticated_json_delete admin, "admin/menu_items/#{menu_item.id}"
      end.to change(MenuItem, :count).by(-1)
    end
  end

  describe "not authenticated" do
    it "should return not authorized" do
      json_delete "admin/menu_items/#{menu_item.id}"
      expect(response.status).to be(401)
    end
  end

end

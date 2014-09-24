require 'spec_helper'

describe "menu_items#destroy", :type => :request do

  let! :menu_item do
    FactoryGirl.create(:menu_item)
  end

  describe "DELETE /admin/menu_items/:id" do
    it "redirects to admin menus path" do

      delete "admin/menu_items/#{menu_item.id}"

      expect(response).to redirect_to( admin_menus_path )
    end

    it "should delete information" do
      expect do
        delete "admin/menu_items/#{menu_item.id}"
      end.to change(MenuItem, :count).by(-1)
    end
  end
end
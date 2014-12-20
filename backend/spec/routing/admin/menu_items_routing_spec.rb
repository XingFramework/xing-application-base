require 'spec_helper'

describe Admin::MenuItemsController, :type => :routing do
  describe "routing" do
    it "recognizes and generates #show" do
      expect({ :get => "/admin/menu_items/1" }).to route_to(:controller => "admin/menu_items", :action => "show", :id => "1")
    end

    it "recognizes and generates #create" do
      expect({ :post => "/admin/menu_items" }).to route_to(:controller => "admin/menu_items", :action => "create")
    end

    it "recognizes and generates #update" do
      expect({ :put => "/admin/menu_items/1" }).to route_to(:controller => "admin/menu_items", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/menu_items/1" }.should route_to(:controller => "admin/menu_items", :action => "destroy", :id => "1")
    end
  end
end

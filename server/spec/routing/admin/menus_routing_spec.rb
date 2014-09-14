require 'spec_helper'

describe Admin::MenusController do
  describe "routing" do
    it "recognizes and generates #index" do
      expect({ :get => "/admin/menus" }).to route_to(:controller => "admin/menus", :action => "index")
    end
    it "recognizes and generates #show" do
      expect({ :get => "/admin/menus/1" }).to route_to(:controller => "admin/menus", :action => "show", :id => "1")
    end

  end
end

require 'spec_helper'

describe MenusController, :type => :routing do
  describe "routing" do
    it "recognizes and generates #show" do
      { :get => "/navigation/main" }.should route_to(:controller => "menus", :action => "show", :id => Menu.main_menu.id)
    end

    it "recognizes and generates #index" do
      expect({ :get => "/menus" }).to route_to(:controller => "menus", :action => "index")
    end

    it "recognizes and generates #show" do
      expect({ :get => "/menus/1" }).to route_to(:controller => "menus", :action => "show", :id => "1")
    end

    it "recognizes and generates #update" do
      expect({ :put => "/menus/1" }).to route_to(:controller => "menus", :action => "update", :id => "1")
    end

  end
end

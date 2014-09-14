require 'spec_helper'

describe MenusController do
  describe "routing" do
    it "recognizes and generates #show" do
      { :get => "/navigation/main" }.should route_to(:controller => "menus", :action => "show", :id => Menu.main_menu.id)
    end
  end
end

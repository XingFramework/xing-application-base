require 'spec_helper'

describe MainMenuController do
  describe "routing" do
    it "recognizes and generates #show" do
      { :get => "/navigation/main" }.should route_to(:controller => "main_menu", :action => "show")
    end
  end
end

require 'spec_helper'

describe PagesController do
  describe "routing" do
    it "recognizes and generates #show" do
      { :get => "/some_page" }.should route_to(:controller => "pages", :action => "show", :permalink => 'some_page')
    end
    it "recognizes and generates #show with complex path" do
      { :get => "/some/page" }.should route_to(:controller => "pages", :action => "show", :permalink => 'some/page')
    end
  end
end

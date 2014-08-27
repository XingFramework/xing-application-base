require 'spec_helper'

describe Admin::PagesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/pages" }.should route_to(:controller => "admin/pages", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/pages/new" }.should route_to(:controller => "admin/pages", :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/pages/1/edit" }.should route_to(:controller => "admin/pages", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/pages" }.should route_to(:controller => "admin/pages", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/pages/1" }.should route_to(:controller => "admin/pages", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/pages/1" }.should route_to(:controller => "admin/pages", :action => "destroy", :id => "1")
    end
  end
end

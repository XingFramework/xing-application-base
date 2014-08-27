require 'spec_helper'

describe Admin::ImagesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/images" }.should route_to(:controller => "admin/images", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/images/new" }.should route_to(:controller => "admin/images", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/images/1" }.should route_to(:controller => "admin/images", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/images/1/edit" }.should route_to(:controller => "admin/images", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/images" }.should route_to(:controller => "admin/images", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/images/1" }.should route_to(:controller => "admin/images", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/images/1" }.should route_to(:controller => "admin/images", :action => "destroy", :id => "1")
    end
  end
end

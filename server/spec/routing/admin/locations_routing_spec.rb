require 'spec_helper'

describe Admin::LocationsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/locations" }.should route_to(:controller => "admin/locations", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/locations/new" }.should route_to(:controller => "admin/locations", :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/locations/1/edit" }.should route_to(:controller => "admin/locations", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/locations" }.should route_to(:controller => "admin/locations", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/locations/1" }.should route_to(:controller => "admin/locations", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/locations/1" }.should route_to(:controller => "admin/locations", :action => "destroy", :id => "1")
    end
  end
end

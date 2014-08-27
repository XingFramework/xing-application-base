require 'spec_helper'

describe Admin::DocumentsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/documents" }.should route_to(:controller => "admin/documents", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/documents/new" }.should route_to(:controller => "admin/documents", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/documents/1" }.should route_to(:controller => "admin/documents", :action => "show", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/documents" }.should route_to(:controller => "admin/documents", :action => "create")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/documents/1" }.should route_to(:controller => "admin/documents", :action => "destroy", :id => "1")
    end
  end
end

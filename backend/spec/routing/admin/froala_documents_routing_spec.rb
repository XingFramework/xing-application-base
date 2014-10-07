require 'spec_helper'

describe Admin::FroalaDocumentsController do
  describe "routing" do
    xit "recognizes and generates #index" do
      { :get => "/admin/documents" }.should route_to(:controller => "admin/documents", :action => "index")
    end

    xit "recognizes and generates #new" do
      { :get => "/admin/documents/new" }.should route_to(:controller => "admin/documents", :action => "new")
    end

    xit "recognizes and generates #show" do
      { :get => "/admin/documents/1" }.should route_to(:controller => "admin/documents", :action => "show", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/froala_documents" }.should route_to(:controller => "admin/froala_documents", :action => "create")
    end

    xit "recognizes and generates #destroy" do
      { :delete => "/admin/documents/1" }.should route_to(:controller => "admin/documents", :action => "destroy", :id => "1")
    end
  end
end

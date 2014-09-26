require 'spec_helper'

describe Admin::FroalaImagesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/froala_images" }.should route_to(:controller => "admin/froala_images", :action => "index")
    end

    xit "recognizes and generates #show" do
      { :get => "/admin/froala_images/1" }.should route_to(:controller => "admin/froala_images", :action => "show", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/froala_images" }.should route_to(:controller => "admin/froala_images", :action => "create")
    end

    xit "recognizes and generates #update" do
      { :put => "/admin/froala_images/1" }.should route_to(:controller => "admin/froala_images", :action => "update", :id => "1")
    end

    xit "recognizes and generates #destroy" do
      { :delete => "/admin/froala_images/1" }.should route_to(:controller => "admin/froala_images", :action => "destroy", :id => "1")
    end
  end
end

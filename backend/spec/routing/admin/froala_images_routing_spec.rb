require 'spec_helper'

describe Admin::FroalaImagesController, :type => :routing do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/froala_images" }.should route_to(:controller => "admin/froala_images", :action => "index")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/froala_images" }.should route_to(:controller => "admin/froala_images", :action => "create")
    end

    it "recognizes and generates #destroy" do
      { :post => "/admin/froala_images/delete" }.should route_to(:controller => "admin/froala_images", :action => "destroy")
    end
  end
end

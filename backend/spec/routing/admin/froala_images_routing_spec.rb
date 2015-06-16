require 'spec_helper'

describe Admin::FroalaImagesController, :type => :routing do
  describe "routing" do
    it "recognizes and generates #index" do
      expect({ :get => "/admin/froala_images" }).to route_to(:controller => "admin/froala_images", :action => "index")
    end

    it "recognizes and generates #create" do
      expect({ :post => "/admin/froala_images" }).to route_to(:controller => "admin/froala_images", :action => "create")
    end

    it "recognizes and generates #destroy" do
      expect({ :post => "/admin/froala_images/delete" }).to route_to(:controller => "admin/froala_images", :action => "destroy")
    end
  end
end

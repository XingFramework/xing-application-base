require 'spec_helper'

describe Admin::PagesController, :type => :routing do
  describe "routing" do
    it "recognizes and generates #show" do
      expect({ :get => "/admin/pages/url_slug" }).to route_to(:controller => "admin/pages", :action => "show", :url_slug => "url_slug")
    end

    it "recognizes and generates #create" do
      expect({ :post => "/admin/pages" }).to route_to(:controller => "admin/pages", :action => "create")
    end

    it "recognizes and generates #update" do
      expect({ :put => "/admin/pages/url_slug" }).to route_to(:controller => "admin/pages", :action => "update", :url_slug => "url_slug")
    end
    it "recognizes and generates #index" do
      expect({ :get => "/admin/pages" }).to route_to(:controller => "admin/pages", :action => "index")
    end

    it "recognizes and generates #destroy" do
      expect({ :delete => "/admin/pages/url_slug" }).to route_to(:controller => "admin/pages", :action => "destroy", :url_slug => "url_slug")
    end
  end
end

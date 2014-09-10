require 'spec_helper'

describe PagesController do
  describe "routing" do
    it "recognizes and generates #show" do
      expect({ :get => "pages/url_slug" }).to route_to(:controller => "pages", :action => "show", :url_slug => 'url_slug')
    end

    it "recognizes and generates /homepage" do
      expect({ :get => "homepage" }).to route_to(:controller => "pages", :action => "show", :url_slug => 'homepage')
    end
  end
end

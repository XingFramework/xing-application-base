require 'spec_helper'

describe StaticController, :pending => "Awaiting implementation in CMS2" do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/" }.should route_to(:controller => "static", :action => "index")
    end
  end
end

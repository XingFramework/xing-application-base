require 'spec_helper'

describe ClientRoutesController, :type => :routing do
  describe "routing" do
    it "recognizes and generates #show" do
      expect({ :get => "pages/about_us?_escaped_fragment_=" }).to frontend_route_to(:controller => "client_routes", :action => "show", :path => 'pages/about_us', :_escaped_fragment_ => "")
    end
  end
end

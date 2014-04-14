require "spec_helper"

describe SegmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/segments").should route_to("segments#index")
    end

    it "routes to #new" do
      get("/segments/new").should route_to("segments#new")
    end

    it "routes to #show" do
      get("/segments/1").should route_to("segments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/segments/1/edit").should route_to("segments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/segments").should route_to("segments#create")
    end

    it "routes to #update" do
      put("/segments/1").should route_to("segments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/segments/1").should route_to("segments#destroy", :id => "1")
    end

  end
end

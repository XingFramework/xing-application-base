require "spec_helper"

describe HitsController do
  describe "routing" do

    it "routes to #index" do
      get("/hits").should route_to("hits#index")
    end

    it "routes to #new" do
      get("/hits/new").should route_to("hits#new")
    end

    it "routes to #show" do
      get("/hits/1").should route_to("hits#show", :id => "1")
    end

    it "routes to #edit" do
      get("/hits/1/edit").should route_to("hits#edit", :id => "1")
    end

    it "routes to #create" do
      post("/hits").should route_to("hits#create")
    end

    it "routes to #update" do
      put("/hits/1").should route_to("hits#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/hits/1").should route_to("hits#destroy", :id => "1")
    end

  end
end

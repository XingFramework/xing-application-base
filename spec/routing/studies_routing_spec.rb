require "spec_helper"

describe StudiesController do
  describe "routing" do

    it "routes to #index" do
      get("/studies").should route_to("studies#index")
    end

    it "routes to #new" do
      get("/studies/new").should route_to("studies#new")
    end

    it "routes to #show" do
      get("/studies/1").should route_to("studies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/studies/1/edit").should route_to("studies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/studies").should route_to("studies#create")
    end

    it "routes to #update" do
      put("/studies/1").should route_to("studies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/studies/1").should route_to("studies#destroy", :id => "1")
    end

  end
end

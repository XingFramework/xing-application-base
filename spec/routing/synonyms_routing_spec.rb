require "spec_helper"

describe SynonymsController do
  describe "routing" do

    it "routes to #index" do
      get("/synonyms").should route_to("synonyms#index")
    end

    it "routes to #new" do
      get("/synonyms/new").should route_to("synonyms#new")
    end

    it "routes to #show" do
      get("/synonyms/1").should route_to("synonyms#show", :id => "1")
    end

    it "routes to #edit" do
      get("/synonyms/1/edit").should route_to("synonyms#edit", :id => "1")
    end

    it "routes to #create" do
      post("/synonyms").should route_to("synonyms#create")
    end

    it "routes to #update" do
      put("/synonyms/1").should route_to("synonyms#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/synonyms/1").should route_to("synonyms#destroy", :id => "1")
    end

  end
end

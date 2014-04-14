require "spec_helper"

describe ResearcherInterestsController do
  describe "routing" do

    it "routes to #index" do
      get("/researcher_interests").should route_to("researcher_interests#index")
    end

    it "routes to #new" do
      get("/researcher_interests/new").should route_to("researcher_interests#new")
    end

    it "routes to #show" do
      get("/researcher_interests/1").should route_to("researcher_interests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/researcher_interests/1/edit").should route_to("researcher_interests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/researcher_interests").should route_to("researcher_interests#create")
    end

    it "routes to #update" do
      put("/researcher_interests/1").should route_to("researcher_interests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/researcher_interests/1").should route_to("researcher_interests#destroy", :id => "1")
    end

  end
end

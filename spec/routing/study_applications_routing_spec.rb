require "spec_helper"

describe StudyApplicationsController do
  describe "routing" do

    it "routes to #index" do
      get("/study_applications").should route_to("study_applications#index")
    end

    it "routes to #new" do
      get("/study_applications/new").should route_to("study_applications#new")
    end

    it "routes to #show" do
      get("/study_applications/1").should route_to("study_applications#show", :id => "1")
    end

    it "routes to #edit" do
      get("/study_applications/1/edit").should route_to("study_applications#edit", :id => "1")
    end

    it "routes to #create" do
      post("/study_applications").should route_to("study_applications#create")
    end

    it "routes to #update" do
      put("/study_applications/1").should route_to("study_applications#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/study_applications/1").should route_to("study_applications#destroy", :id => "1")
    end

  end
end

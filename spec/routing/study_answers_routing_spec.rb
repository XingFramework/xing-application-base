require "spec_helper"

describe StudyAnswersController do
  describe "routing" do

    it "routes to #index" do
      get("/study_answers").should route_to("study_answers#index")
    end

    it "routes to #new" do
      get("/study_answers/new").should route_to("study_answers#new")
    end

    it "routes to #show" do
      get("/study_answers/1").should route_to("study_answers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/study_answers/1/edit").should route_to("study_answers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/study_answers").should route_to("study_answers#create")
    end

    it "routes to #update" do
      put("/study_answers/1").should route_to("study_answers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/study_answers/1").should route_to("study_answers#destroy", :id => "1")
    end

  end
end

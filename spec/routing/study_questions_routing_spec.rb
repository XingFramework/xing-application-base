require "spec_helper"

describe StudyQuestionsController do
  describe "routing" do

    it "routes to #index" do
      get("/study_questions").should route_to("study_questions#index")
    end

    it "routes to #new" do
      get("/study_questions/new").should route_to("study_questions#new")
    end

    it "routes to #show" do
      get("/study_questions/1").should route_to("study_questions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/study_questions/1/edit").should route_to("study_questions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/study_questions").should route_to("study_questions#create")
    end

    it "routes to #update" do
      put("/study_questions/1").should route_to("study_questions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/study_questions/1").should route_to("study_questions#destroy", :id => "1")
    end

  end
end

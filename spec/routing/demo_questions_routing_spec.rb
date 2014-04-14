require "spec_helper"

describe DemoQuestionsController do
  describe "routing" do

    it "routes to #index" do
      get("/demo_questions").should route_to("demo_questions#index")
    end

    it "routes to #new" do
      get("/demo_questions/new").should route_to("demo_questions#new")
    end

    it "routes to #show" do
      get("/demo_questions/1").should route_to("demo_questions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/demo_questions/1/edit").should route_to("demo_questions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/demo_questions").should route_to("demo_questions#create")
    end

    it "routes to #update" do
      put("/demo_questions/1").should route_to("demo_questions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/demo_questions/1").should route_to("demo_questions#destroy", :id => "1")
    end

  end
end

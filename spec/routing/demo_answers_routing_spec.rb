require "spec_helper"

describe DemoAnswersController do
  describe "routing" do

    it "routes to #index" do
      get("/demo_answers").should route_to("demo_answers#index")
    end

    it "routes to #new" do
      get("/demo_answers/new").should route_to("demo_answers#new")
    end

    it "routes to #show" do
      get("/demo_answers/1").should route_to("demo_answers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/demo_answers/1/edit").should route_to("demo_answers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/demo_answers").should route_to("demo_answers#create")
    end

    it "routes to #update" do
      put("/demo_answers/1").should route_to("demo_answers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/demo_answers/1").should route_to("demo_answers#destroy", :id => "1")
    end

  end
end

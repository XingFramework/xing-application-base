require "spec_helper"

describe DemoResponsesController do
  describe "routing" do

    it "routes to #index" do
      get("/demo_responses").should route_to("demo_responses#index")
    end

    it "routes to #new" do
      get("/demo_responses/new").should route_to("demo_responses#new")
    end

    it "routes to #show" do
      get("/demo_responses/1").should route_to("demo_responses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/demo_responses/1/edit").should route_to("demo_responses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/demo_responses").should route_to("demo_responses#create")
    end

    it "routes to #update" do
      put("/demo_responses/1").should route_to("demo_responses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/demo_responses/1").should route_to("demo_responses#destroy", :id => "1")
    end

  end
end

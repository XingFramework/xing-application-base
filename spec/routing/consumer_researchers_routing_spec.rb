require "spec_helper"

describe ConsumerResearchersController do
  describe "routing" do

    it "routes to #index" do
      get("/consumer_researchers").should route_to("consumer_researchers#index")
    end

    it "routes to #new" do
      get("/consumer_researchers/new").should route_to("consumer_researchers#new")
    end

    it "routes to #show" do
      get("/consumer_researchers/1").should route_to("consumer_researchers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/consumer_researchers/1/edit").should route_to("consumer_researchers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/consumer_researchers").should route_to("consumer_researchers#create")
    end

    it "routes to #update" do
      put("/consumer_researchers/1").should route_to("consumer_researchers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/consumer_researchers/1").should route_to("consumer_researchers#destroy", :id => "1")
    end

  end
end

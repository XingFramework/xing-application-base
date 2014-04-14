require "spec_helper"

describe ScreenerAnswersController do
  describe "routing" do

    it "routes to #index" do
      get("/screener_answers").should route_to("screener_answers#index")
    end

    it "routes to #new" do
      get("/screener_answers/new").should route_to("screener_answers#new")
    end

    it "routes to #show" do
      get("/screener_answers/1").should route_to("screener_answers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/screener_answers/1/edit").should route_to("screener_answers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/screener_answers").should route_to("screener_answers#create")
    end

    it "routes to #update" do
      put("/screener_answers/1").should route_to("screener_answers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/screener_answers/1").should route_to("screener_answers#destroy", :id => "1")
    end

  end
end

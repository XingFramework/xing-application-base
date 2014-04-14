require "spec_helper"

describe ScreenerQuestionsController do
  describe "routing" do

    it "routes to #index" do
      get("/screener_questions").should route_to("screener_questions#index")
    end

    it "routes to #new" do
      get("/screener_questions/new").should route_to("screener_questions#new")
    end

    it "routes to #show" do
      get("/screener_questions/1").should route_to("screener_questions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/screener_questions/1/edit").should route_to("screener_questions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/screener_questions").should route_to("screener_questions#create")
    end

    it "routes to #update" do
      put("/screener_questions/1").should route_to("screener_questions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/screener_questions/1").should route_to("screener_questions#destroy", :id => "1")
    end

  end
end

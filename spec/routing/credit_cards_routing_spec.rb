require "spec_helper"

describe CreditCardsController do
  describe "routing" do

    it "routes to #index" do
      get("/credit_cards").should route_to("credit_cards#index")
    end

    it "routes to #new" do
      get("/credit_cards/new").should route_to("credit_cards#new")
    end

    it "routes to #show" do
      get("/credit_cards/1").should route_to("credit_cards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/credit_cards/1/edit").should route_to("credit_cards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/credit_cards").should route_to("credit_cards#create")
    end

    it "routes to #update" do
      put("/credit_cards/1").should route_to("credit_cards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/credit_cards/1").should route_to("credit_cards#destroy", :id => "1")
    end

  end
end

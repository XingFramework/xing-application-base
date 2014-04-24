require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to #show" do
      get("/users").should route_to("users#show")
    end

  end
end

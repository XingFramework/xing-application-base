require 'spec_helper'

describe "ConsumerResearchers" do
  describe "GET /consumer_researchers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get consumer_researchers_path
      response.status.should be(200)
    end
  end
end

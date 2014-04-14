require 'spec_helper'

describe "ResearcherInterests" do
  describe "GET /researcher_interests" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get researcher_interests_path
      response.status.should be(200)
    end
  end
end

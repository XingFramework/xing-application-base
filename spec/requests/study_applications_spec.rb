require 'spec_helper'

describe "StudyApplications" do
  describe "GET /study_applications" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get study_applications_path
      response.status.should be(200)
    end
  end
end

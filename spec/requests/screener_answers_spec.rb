require 'spec_helper'

describe "ScreenerAnswers" do
  describe "GET /screener_answers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get screener_answers_path
      response.status.should be(200)
    end
  end
end

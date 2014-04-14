require 'spec_helper'

describe "screener_questions/show" do
  before(:each) do
    @screener_question = assign(:screener_question, stub_model(ScreenerQuestion,
      :text => "MyText",
      :options => "MyText",
      :study_id => 1,
      :answer_type => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end

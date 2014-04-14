require 'spec_helper'

describe "screener_answers/show" do
  before(:each) do
    @screener_answer = assign(:screener_answer, stub_model(ScreenerAnswer,
      :text => "MyText",
      :study_application_id => 1,
      :screener_question_id => 2,
      :rating => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end

require 'spec_helper'

describe "screener_answers/index" do
  before(:each) do
    assign(:screener_answers, [
      stub_model(ScreenerAnswer,
        :text => "MyText",
        :study_application_id => 1,
        :screener_question_id => 2,
        :rating => 3
      ),
      stub_model(ScreenerAnswer,
        :text => "MyText",
        :study_application_id => 1,
        :screener_question_id => 2,
        :rating => 3
      )
    ])
  end

  it "renders a list of screener_answers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end

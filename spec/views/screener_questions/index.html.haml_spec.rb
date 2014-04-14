require 'spec_helper'

describe "screener_questions/index" do
  before(:each) do
    assign(:screener_questions, [
      stub_model(ScreenerQuestion,
        :text => "MyText",
        :options => "MyText",
        :study_id => 1,
        :answer_type => 2
      ),
      stub_model(ScreenerQuestion,
        :text => "MyText",
        :options => "MyText",
        :study_id => 1,
        :answer_type => 2
      )
    ])
  end

  it "renders a list of screener_questions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end

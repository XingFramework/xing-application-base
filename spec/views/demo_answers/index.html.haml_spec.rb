require 'spec_helper'

describe "demo_answers/index" do
  before(:each) do
    assign(:demo_answers, [
      stub_model(DemoAnswer,
        :text => "Text",
        :position => 1,
        :demo_question_id => 2
      ),
      stub_model(DemoAnswer,
        :text => "Text",
        :position => 1,
        :demo_question_id => 2
      )
    ])
  end

  it "renders a list of demo_answers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Text".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end

require 'spec_helper'

describe "demo_questions/index" do
  before(:each) do
    assign(:demo_questions, [
      stub_model(DemoQuestion,
        :text => "Text",
        :caption => "Caption",
        :position => 1,
        :multiple => false
      ),
      stub_model(DemoQuestion,
        :text => "Text",
        :caption => "Caption",
        :position => 1,
        :multiple => false
      )
    ])
  end

  it "renders a list of demo_questions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Text".to_s, :count => 2
    assert_select "tr>td", :text => "Caption".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end

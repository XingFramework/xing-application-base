require 'spec_helper'

describe "demo_answers/show" do
  before(:each) do
    @demo_answer = assign(:demo_answer, stub_model(DemoAnswer,
      :text => "Text",
      :position => 1,
      :demo_question_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Text/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end

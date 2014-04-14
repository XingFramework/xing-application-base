require 'spec_helper'

describe "demo_questions/show" do
  before(:each) do
    @demo_question = assign(:demo_question, stub_model(DemoQuestion,
      :text => "Text",
      :caption => "Caption",
      :position => 1,
      :multiple => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Text/)
    rendered.should match(/Caption/)
    rendered.should match(/1/)
    rendered.should match(/false/)
  end
end

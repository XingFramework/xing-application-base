require 'spec_helper'

describe "demo_questions/edit" do
  before(:each) do
    @demo_question = assign(:demo_question, stub_model(DemoQuestion,
      :text => "MyString",
      :caption => "MyString",
      :position => 1,
      :multiple => false
    ))
  end

  it "renders the edit demo_question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", demo_question_path(@demo_question), "post" do
      assert_select "input#demo_question_text[name=?]", "demo_question[text]"
      assert_select "input#demo_question_caption[name=?]", "demo_question[caption]"
      assert_select "input#demo_question_position[name=?]", "demo_question[position]"
      assert_select "input#demo_question_multiple[name=?]", "demo_question[multiple]"
    end
  end
end

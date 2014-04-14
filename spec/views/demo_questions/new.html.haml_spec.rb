require 'spec_helper'

describe "demo_questions/new" do
  before(:each) do
    assign(:demo_question, stub_model(DemoQuestion,
      :text => "MyString",
      :caption => "MyString",
      :position => 1,
      :multiple => false
    ).as_new_record)
  end

  it "renders new demo_question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", demo_questions_path, "post" do
      assert_select "input#demo_question_text[name=?]", "demo_question[text]"
      assert_select "input#demo_question_caption[name=?]", "demo_question[caption]"
      assert_select "input#demo_question_position[name=?]", "demo_question[position]"
      assert_select "input#demo_question_multiple[name=?]", "demo_question[multiple]"
    end
  end
end

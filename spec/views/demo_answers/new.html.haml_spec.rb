require 'spec_helper'

describe "demo_answers/new" do
  before(:each) do
    assign(:demo_answer, stub_model(DemoAnswer,
      :text => "MyString",
      :position => 1,
      :demo_question_id => 1
    ).as_new_record)
  end

  it "renders new demo_answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", demo_answers_path, "post" do
      assert_select "input#demo_answer_text[name=?]", "demo_answer[text]"
      assert_select "input#demo_answer_position[name=?]", "demo_answer[position]"
      assert_select "input#demo_answer_demo_question_id[name=?]", "demo_answer[demo_question_id]"
    end
  end
end

require 'spec_helper'

describe "demo_answers/edit" do
  before(:each) do
    @demo_answer = assign(:demo_answer, stub_model(DemoAnswer,
      :text => "MyString",
      :position => 1,
      :demo_question_id => 1
    ))
  end

  it "renders the edit demo_answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", demo_answer_path(@demo_answer), "post" do
      assert_select "input#demo_answer_text[name=?]", "demo_answer[text]"
      assert_select "input#demo_answer_position[name=?]", "demo_answer[position]"
      assert_select "input#demo_answer_demo_question_id[name=?]", "demo_answer[demo_question_id]"
    end
  end
end

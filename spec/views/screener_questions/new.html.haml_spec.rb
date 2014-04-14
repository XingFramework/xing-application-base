require 'spec_helper'

describe "screener_questions/new" do
  before(:each) do
    assign(:screener_question, stub_model(ScreenerQuestion,
      :text => "MyText",
      :options => "MyText",
      :study_id => 1,
      :answer_type => 1
    ).as_new_record)
  end

  it "renders new screener_question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", screener_questions_path, "post" do
      assert_select "textarea#screener_question_text[name=?]", "screener_question[text]"
      assert_select "textarea#screener_question_options[name=?]", "screener_question[options]"
      assert_select "input#screener_question_study_id[name=?]", "screener_question[study_id]"
      assert_select "input#screener_question_answer_type[name=?]", "screener_question[answer_type]"
    end
  end
end

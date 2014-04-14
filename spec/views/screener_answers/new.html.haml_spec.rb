require 'spec_helper'

describe "screener_answers/new" do
  before(:each) do
    assign(:screener_answer, stub_model(ScreenerAnswer,
      :text => "MyText",
      :study_application_id => 1,
      :screener_question_id => 1,
      :rating => 1
    ).as_new_record)
  end

  it "renders new screener_answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", screener_answers_path, "post" do
      assert_select "textarea#screener_answer_text[name=?]", "screener_answer[text]"
      assert_select "input#screener_answer_study_application_id[name=?]", "screener_answer[study_application_id]"
      assert_select "input#screener_answer_screener_question_id[name=?]", "screener_answer[screener_question_id]"
      assert_select "input#screener_answer_rating[name=?]", "screener_answer[rating]"
    end
  end
end

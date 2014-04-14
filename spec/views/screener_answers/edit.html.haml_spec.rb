require 'spec_helper'

describe "screener_answers/edit" do
  before(:each) do
    @screener_answer = assign(:screener_answer, stub_model(ScreenerAnswer,
      :text => "MyText",
      :study_application_id => 1,
      :screener_question_id => 1,
      :rating => 1
    ))
  end

  it "renders the edit screener_answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", screener_answer_path(@screener_answer), "post" do
      assert_select "textarea#screener_answer_text[name=?]", "screener_answer[text]"
      assert_select "input#screener_answer_study_application_id[name=?]", "screener_answer[study_application_id]"
      assert_select "input#screener_answer_screener_question_id[name=?]", "screener_answer[screener_question_id]"
      assert_select "input#screener_answer_rating[name=?]", "screener_answer[rating]"
    end
  end
end

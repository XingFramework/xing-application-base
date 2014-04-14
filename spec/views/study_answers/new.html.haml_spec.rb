require 'spec_helper'

describe "study_answers/new" do
  before(:each) do
    assign(:study_answer, stub_model(StudyAnswer,
      :study_question_id => 1,
      :study_application_id => 1,
      :latitude => 1.5,
      :longitude => 1.5
    ).as_new_record)
  end

  it "renders new study_answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", study_answers_path, "post" do
      assert_select "input#study_answer_study_question_id[name=?]", "study_answer[study_question_id]"
      assert_select "input#study_answer_study_application_id[name=?]", "study_answer[study_application_id]"
      assert_select "input#study_answer_latitude[name=?]", "study_answer[latitude]"
      assert_select "input#study_answer_longitude[name=?]", "study_answer[longitude]"
    end
  end
end

require 'spec_helper'

describe "study_answers/show" do
  before(:each) do
    @study_answer = assign(:study_answer, stub_model(StudyAnswer,
      :study_question_id => 1,
      :study_application_id => 2,
      :latitude => 1.5,
      :longitude => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
  end
end

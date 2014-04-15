require 'spec_helper'

describe "study_answers/index" do
  before(:each) do
    assign(:study_answers, [
      stub_model(StudyAnswer,
        :study_question_id => 1,
        :study_application_id => 2,
        :latitude => 3.5,
        :longitude => 4.5
      ),
      stub_model(StudyAnswer,
        :study_question_id => 1,
        :study_application_id => 2,
        :latitude => 3.5,
        :longitude => 4.5
      )
    ])
  end

  it "renders a list of study_answers" do
    render

    #debugger
    rendered.should have_css("tr>td", :text => 1.to_s, :count => 2)
    rendered.should have_css("tr>td", :text => 2.to_s, :count => 2)
    rendered.should have_css("tr>td", :text => 3.5.to_s, :count => 2)
    rendered.should have_css("tr>td", :text => 4.5.to_s, :count => 2)
  end
end

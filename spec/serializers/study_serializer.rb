require "spec_helper"

describe StudySerializer do
  let :study do
    FactoryGirl.build_stubbed(
      :study,
      :screener_questions => [
        FactoryGirl.build_stubbed(:screener_question_single),
        FactoryGirl.build_stubbed(:screener_question_multiple),
        FactoryGirl.build_stubbed(:screener_question_open)
      ]
    )
  end

  describe 'as_json' do
    subject :json do
      StudySerializer.new(study).to_json
    end

    it { should be_present }
    it { should have_json_path('study/id') }
    it { should have_json_path('study/title') }
    it { should have_json_size(3).at_path("study/screener_questions") }
    it { should have_json_type(Array).at_path('study/screener_questions')}
    it { should have_json_type(Array).at_path('study/screener_questions/0/options')}
  end
end

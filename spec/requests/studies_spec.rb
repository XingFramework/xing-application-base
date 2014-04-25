require 'spec_helper'

describe "Studies", :json => true do

  def study_with_questions(user, title)
    FactoryGirl.create(
      :study,
      :title => title,
      :researcher => user,
      :screener_questions => [
        FactoryGirl.create(:screener_question_single),
        FactoryGirl.create(:screener_question_multiple),
        FactoryGirl.create(:screener_question_open)
      ]
    )
  end

  let :user       do FactoryGirl.create(:researcher_user) end
  let :other_user do FactoryGirl.create(:researcher_user) end

  let :my_studies do [
      study_with_questions(user, 'Study 1'),
      study_with_questions(user, 'Study 2')
    ]
  end

  let :other_study do
    study_with_questions(other_user, 'Study 3')
  end

  describe "GET /studies" do
    before do
      my_studies; other_study
      json_get studies_path, :owner => user.id
    end

    it "succeeds" do
      response.status.should be(200)
    end

    context "returned JSON" do
      subject :json do response.body.tap{|j| p j} end

      it { should have_json_type(Array).at_path('') }
      it { should have_json_size(2).at_path('') }
      it "should contain the researcher's own studies", :pending => 'figure out how to write this' do
        should include_json(StudySerializer.new(my_studies[0]).to_json).at_path('studies/0/study')
        should include_json(StudySerializer.new(my_studies[1]).to_json).at_path('studies/1/study')
      end
      it "should not contain the other study", :pending => 'figure out how to write this' do
        should_not include_json(StudySerializer.new(other_study).to_json)
      end
    end

  end
end

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
  let :current_user do user end

  let :my_studies do [
      study_with_questions(user, 'Study 1'),
      study_with_questions(user, 'Study 2')
    ]
  end

  let :other_study do
    study_with_questions(other_user, 'Study 3')
  end


  # TODO: re-do this with rspec-steps so we only have to do the post once
  describe "POST /studies" do
    before do user end

    context "with valid data" do

      let :post_study_json do
        add_to_json(
          json_fixture('studies/post_study.json'),
          :user_id => user.id
        )
      end

      it "succeeds" do
        json_post studies_path, post_study_json
        response.should be_success
      end

      it "creates a study in the database with three screener questions", :pending => 'this is next' do
        expect do
          expect do
            json_post studies_path, post_study_json
          end.to change(Study.count).by(1)
        end.to change(ScreenerQuestion.count).by(3)
      end

      it "creates a study owned by the correct user", :pending => 'this is next' do
        json_post studies_path, post_study_json
        assigns(:study).user.should == user
      end

      context "response", :pending => 'this is next' do
        subject :json do
          json_post studies_path, post_study_json
          @study = Study.last
          response.body
        end

        it { should be_json_eq(@study.to_json) }
      end

    end
  end

  describe "GET /studies" do
    before do
      my_studies; other_study
      json_get studies_path, get_params, :user_id => user.id
    end

    let :get_params do
      { :owner_id => user.id }
    end

    it "succeeds" do
      response.status.should be(200)
    end

    context "returned JSON" do
      subject :json do response.body end

      it { should have_json_type(Array).at_path('') }
      it { should have_json_size(2).at_path('') }

      it "should contain the researcher's own studies, v2"  do
        should include_json(StudySerializer.new(my_studies[0]).to_json)
        should include_json(StudySerializer.new(my_studies[1]).to_json)
      end

      it "should not contain the other study" do
        should_not include_json(StudySerializer.new(other_study).to_json)
        should_not =~ /#{other_study.title}/
      end
    end

  end
end

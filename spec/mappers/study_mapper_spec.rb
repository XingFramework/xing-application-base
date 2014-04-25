require 'spec_helper'

describe StudyMapper, :type => :mapper do

  describe "saving a valid study" do
    let :user       do  FactoryGirl.create(:researcher_user) end
    let :mapper     do  StudyMapper.new(valid_json)   end
    let :valid_json do
      add_to_json(
        json_fixture('studies/post_study'),
        'user_id' => user.id
      )
    end

    it "should save a Study" do
      expect do
        mapper.save
      end.to change(Study, :count).by(1)
    end

    context "returned study" do
      let :parsed_json do JSON.parse(valid_json) end
      subject :study   do mapper.save end

      it          { should be_a(Study) }
      its(:title) { should == parsed_json['title'] }
      it          { should have(3).screener_questions }
      its(:researcher) { should == user }
    end

    # TODO: Isolate the mapper from the database with mocks, probably?
    it 'should correctly associate the questions' do
      study = mapper.save
      questions = study.screener_questions
      questions.each do |qq|
        qq.reload.study.should == study
      end
    end

  end
end

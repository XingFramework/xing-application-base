require 'spec_helper'


describe StudiesController do

  let :user       do
    FactoryGirl.build_stubbed(:researcher_user, :id => user_id)
  end

  let :my_studies do [
      FactoryGirl.build_stubbed(:study),
      FactoryGirl.build_stubbed(:study),
    ]
  end

  let :user_id do '1' end

  before do
    User.stub(:find).with(user_id).and_return(user)
    request.headers["X-User-Id"] = user.id.to_s
  end

  describe "POST create" do
    let :study_values do { :some => 'values' } end
    let :json_body do { :owner => user_id }.merge(study_values).to_json end

    before do
      StudyMapper.stub(:new).and_return(mapper)
    end

    context "successful create", :pending => 'this is next for Evan' do
      let :mapper do
        double(StudyMapper, :save => true)
      end

      it "finds the user" do
        User.should_receive(:find).with(user_id)
        post :create, json_body
      end

      it "instantiates and saves a mapper" do
        StudyMapper.should_receive(:new).with(study_values)
        mapper.should_receive(:save)
        post :create, json_body
      end
    end

    context "failed create" do
      let :mapper do
        double(StudyMapper, :save => false)
      end

      it "should do something"
    end
  end

  describe "GET index" do
    before do
      User.stub(:find).with(user_id).and_return(user)
      user.stub(:studies).and_return(my_studies)
    end

    it "finds the user's studies and assigns them" do
      User.should_receive(:find).with(user_id)
      user.should_receive(:studies)
      get :index, { :owner_id => user_id }
      assigns(:studies).should == my_studies
    end

    it "responds with JSON" do
      get :index, { :owner_id => user_id }
      response.headers["Content-Type"].should =~ /\Aapplication\/json/
    end
  end
end

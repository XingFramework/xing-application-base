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

  describe "GET index" do
    before do
      User.stub(:find).with(user_id).and_return(user)
      user.stub(:studies).and_return(my_studies)
    end

    it "finds the user's studies and assigns them" do
      User.should_receive(:find).with(user_id)
      user.should_receive(:studies)
      get :index, { :owner => user_id }
      assigns(:studies).should == my_studies
    end

    it "responds with JSON" do
      get :index, { :owner => user_id }
      response.headers["Content-Type"].should =~ /\Aapplication\/json/
    end
  end
end

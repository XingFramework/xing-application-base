require 'spec_helper'

describe "Users", :json => true do

  describe "GET /users" do
    let! :user do FactoryGirl.create(:user) end

    it "successfully responds with a user json hash" do
      json_get users_path, { :email => user.email }

      response.status.should be(200)
      json['user'].should be_present
      json['user']['email'].should == user.email
    end
  end
end

require 'spec_helper'

describe UsersController do

  let :user do
    double(User,
           :email => 'john@example.com',
           :as_json => "user: { valid: 'json'} "
          )
  end

  describe "GET show" do

    context "when the user exists" do
      before do
        User.should_receive(:find_by_email).and_return(user)
      end

      it "should get a json representation" do
        user.should_receive(:as_json)
        get :show, {:email => user.email}
      end

      it "should respond with json" do
        get :show, {:email => user.email}
        response.headers["Content-Type"].should =~ /\Aapplication\/json/
      end
    end

    context "when the user does not exist" do
      it "should respond with 404" do
        get :show,{ :email => 'xxxx@xxxx.com' }
        response.status.should == 404
      end
    end
  end

end

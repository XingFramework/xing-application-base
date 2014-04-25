require 'spec_helper'

describe Profile, :pending => true do


  describe 'for' do
    let! :user    do double(User)              end
    let! :profile do double(Profile::Consumer) end

    it "should look up in the registry" do
      profile.should_receive()
      Profile.for(user).should == profile
    end

  end
end

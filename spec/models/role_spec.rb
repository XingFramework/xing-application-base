require 'spec_helper'

describe Role do
  let :researcher_user do FactoryGirl.create(:researcher_user) end
  let :consumer_user    do FactoryGirl.create(:consumer_user) end
  let :admin_user      do FactoryGirl.create(:admin) end

  describe 'registry' do
    before do
      class Role::TestRole < Role
      end
    end

    after do
      Role.registry.delete('test_role')
    end

    it 'should allow registration of role subclasses' do
      Role::TestRole.register('test_role')
      Role.registry['test_role'].should == Role::TestRole
    end
  end

  describe "class methods" do
    before do
      researcher_user
      consumer_user
      admin_user
    end

    describe "for" do
      context 'researcher' do
        subject {Role.for(researcher_user) }
        it { should be_a(Role::Researcher) }
        its(:user) { should == researcher_user }
      end
      context 'consumer' do
        subject {Role.for(consumer_user) }
        it { should be_a(Role::Consumer) }
        its(:user) { should == consumer_user }
      end
      context 'admin' do
        subject {Role.for(admin_user) }
        it { should be_a(Role::Admin) }
        its(:user) { should == admin_user }
      end
    end

    describe "find by scope" do

      context 'researcher' do
        subject {Role::Researcher.users }
        its(:count) { should == 1 }
        its(:first) { should == researcher_user }
      end

      context 'consumer' do
        subject {Role::Consumer.users }
        its(:count) { should == 1 }
        its(:first) { should == consumer_user }
      end

      context 'admin' do
        subject {Role::Admin.users }
        its(:count) { should == 1 }
        its(:first) { should == admin_user }
      end
    end
  end

  describe "initialization and attachment" do

    it "should attach a ResearcherRole to the researcher user" do
      researcher_user.role.should be_a(Role::Researcher)
    end
    it "should attach a ConsumerRole to the researcher user" do
      consumer_user.role.should be_a(Role::Consumer)
    end
    it "should attach a AdminRole to the researcher user" do
      admin_user.role.should be_a(Role::Admin)
    end

    it "should attach the user to the role" do
      [researcher_user, admin_user, consumer_user].each do |user|
        user.role.user.should == user
      end
    end

    it "should return its role name" do
      researcher_user.role.role_name.should == 'Researcher'
    end
  end
end


require 'spec_helper'

describe Role do
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
      admin_user
    end

    describe "for" do
      context 'admin' do
        subject {Role.for(admin_user) }
        it { should be_a(Role::Admin) }
        its(:user) { should == admin_user }
      end
    end

    describe "find by scope" do

      context 'admin' do
        subject {Role::Admin.users }
        its(:count) { should == 1 }
        its(:first) { should == admin_user }
      end
    end
  end

  describe "initialization and attachment" do

    it "should attach a AdminRole to the researcher user" do
      admin_user.role.should be_a(Role::Admin)
    end

    it "should attach the user to the role" do

      # Below should be expanded when future user types are added.
      # I left it as an array of one on purpose.  -ED
      [ admin_user ].each do |user|
        user.role.user.should == user
      end
    end

    it "should return its role name" do
      admin_user.role.role_name.should == 'Admin'
    end
  end
end

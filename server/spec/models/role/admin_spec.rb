require 'spec_helper'
require 'cancan/matchers'

describe Role::Admin do
  let :user do FactoryGirl.create(:admin) end

  describe 'abilities' do
    subject(:ability) { Ability.new(user) }

    it{ expect(ability).to be_able_to :manage, Page }
    it{ expect(ability).to be_able_to :manage, MenuItem }
    it{ expect(ability).to be_able_to :manage, Document }
    it{ expect(ability).to be_able_to :manage, Image }
  end
end

require 'spec_helper'

describe "/admin/locations/index" do
  include LocationsHelper

  let(:home) { FactoryGirl.create(:location, :name => 'home')  }
  let(:location) { FactoryGirl.create(:location, :parent => home)  }
  before do assign(:locations, [location])  end

  it "should succeed" do
    render
  end
end


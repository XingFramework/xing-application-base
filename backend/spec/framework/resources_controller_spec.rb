require 'spec_helper'

describe ResourcesController do

  let :serializer do
    double(ResourcesSerializer)
  end

  ########################################################################################
  #                                      GET SHOW
  ########################################################################################
  describe "responding to GET index" do
    it "should render all routes as json" do
      ResourcesSerializer.should_receive(:new).and_return(:serializer)
      get :index
      expect(assigns[:resources][:page]).to be_a_kind_of(Addressable::Template)
    end
  end
end

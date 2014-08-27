require 'spec_helper'

describe StaticController, :pending => "Awaiting implementation in CMS2" do
  it "should successfully respond to the index action" do
    get :index
    response.should be_success
  end
end

require 'spec_helper'

describe StaticController do
  it "should successfully respond to the index action" do
    get :index
    response.should be_success
  end
end
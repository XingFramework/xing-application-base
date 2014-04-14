require 'spec_helper'

describe "access_tokens/show" do
  before(:each) do
    @access_token = assign(:access_token, stub_model(AccessToken,
      :user_id => 1,
      :email => "Email",
      :token => "Token",
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Email/)
    rendered.should match(/Token/)
    rendered.should match(/Type/)
  end
end

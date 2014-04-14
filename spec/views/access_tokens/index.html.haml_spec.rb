require 'spec_helper'

describe "access_tokens/index" do
  before(:each) do
    assign(:access_tokens, [
      stub_model(AccessToken,
        :user_id => 1,
        :email => "Email",
        :token => "Token",
        :type => "Type"
      ),
      stub_model(AccessToken,
        :user_id => 1,
        :email => "Email",
        :token => "Token",
        :type => "Type"
      )
    ])
  end

  it "renders a list of access_tokens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end

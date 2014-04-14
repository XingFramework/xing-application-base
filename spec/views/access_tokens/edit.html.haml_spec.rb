require 'spec_helper'

describe "access_tokens/edit" do
  before(:each) do
    @access_token = assign(:access_token, stub_model(AccessToken,
      :user_id => 1,
      :email => "MyString",
      :token => "MyString",
      :type => ""
    ))
  end

  it "renders the edit access_token form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", access_token_path(@access_token), "post" do
      assert_select "input#access_token_user_id[name=?]", "access_token[user_id]"
      assert_select "input#access_token_email[name=?]", "access_token[email]"
      assert_select "input#access_token_token[name=?]", "access_token[token]"
      assert_select "input#access_token_type[name=?]", "access_token[type]"
    end
  end
end

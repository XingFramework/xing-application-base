require 'spec_helper'

describe "access_tokens/new" do
  before(:each) do
    assign(:access_token, stub_model(AccessToken,
      :user_id => 1,
      :email => "MyString",
      :token => "MyString",
      :type => ""
    ).as_new_record)
  end

  it "renders new access_token form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", access_tokens_path, "post" do
      assert_select "input#access_token_user_id[name=?]", "access_token[user_id]"
      assert_select "input#access_token_email[name=?]", "access_token[email]"
      assert_select "input#access_token_token[name=?]", "access_token[token]"
      assert_select "input#access_token_type[name=?]", "access_token[type]"
    end
  end
end

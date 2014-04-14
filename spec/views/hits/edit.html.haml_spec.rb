require 'spec_helper'

describe "hits/edit" do
  before(:each) do
    @hit = assign(:hit, stub_model(Hit,
      :user_id => 1,
      :ip => "MyString",
      :request => "MyText",
      :params => "MyText"
    ))
  end

  it "renders the edit hit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", hit_path(@hit), "post" do
      assert_select "input#hit_user_id[name=?]", "hit[user_id]"
      assert_select "input#hit_ip[name=?]", "hit[ip]"
      assert_select "textarea#hit_request[name=?]", "hit[request]"
      assert_select "textarea#hit_params[name=?]", "hit[params]"
    end
  end
end

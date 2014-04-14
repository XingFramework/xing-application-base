require 'spec_helper'

describe "demo_responses/new" do
  before(:each) do
    assign(:demo_response, stub_model(DemoResponse,
      :user_id => 1,
      :demo_answer_id => 1
    ).as_new_record)
  end

  it "renders new demo_response form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", demo_responses_path, "post" do
      assert_select "input#demo_response_user_id[name=?]", "demo_response[user_id]"
      assert_select "input#demo_response_demo_answer_id[name=?]", "demo_response[demo_answer_id]"
    end
  end
end

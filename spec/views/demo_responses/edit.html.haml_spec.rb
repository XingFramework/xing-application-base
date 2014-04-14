require 'spec_helper'

describe "demo_responses/edit" do
  before(:each) do
    @demo_response = assign(:demo_response, stub_model(DemoResponse,
      :user_id => 1,
      :demo_answer_id => 1
    ))
  end

  it "renders the edit demo_response form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", demo_response_path(@demo_response), "post" do
      assert_select "input#demo_response_user_id[name=?]", "demo_response[user_id]"
      assert_select "input#demo_response_demo_answer_id[name=?]", "demo_response[demo_answer_id]"
    end
  end
end

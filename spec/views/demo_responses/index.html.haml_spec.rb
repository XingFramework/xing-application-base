require 'spec_helper'

describe "demo_responses/index" do
  before(:each) do
    assign(:demo_responses, [
      stub_model(DemoResponse,
        :user_id => 1,
        :demo_answer_id => 2
      ),
      stub_model(DemoResponse,
        :user_id => 1,
        :demo_answer_id => 2
      )
    ])
  end

  it "renders a list of demo_responses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end

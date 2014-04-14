require 'spec_helper'

describe "demo_responses/show" do
  before(:each) do
    @demo_response = assign(:demo_response, stub_model(DemoResponse,
      :user_id => 1,
      :demo_answer_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end

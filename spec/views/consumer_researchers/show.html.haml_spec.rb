require 'spec_helper'

describe "consumer_researchers/show" do
  before(:each) do
    @consumer_researcher = assign(:consumer_researcher, stub_model(ConsumerResearcher,
      :consumer_id => 1,
      :researcher_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end

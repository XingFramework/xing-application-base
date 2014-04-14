require 'spec_helper'

describe "consumer_researchers/index" do
  before(:each) do
    assign(:consumer_researchers, [
      stub_model(ConsumerResearcher,
        :consumer_id => 1,
        :researcher_id => 2
      ),
      stub_model(ConsumerResearcher,
        :consumer_id => 1,
        :researcher_id => 2
      )
    ])
  end

  it "renders a list of consumer_researchers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end

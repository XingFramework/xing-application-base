require 'spec_helper'

describe "segments/index" do
  before(:each) do
    assign(:segments, [
      stub_model(Segment,
        :name => "Name",
        :study_id => 1
      ),
      stub_model(Segment,
        :name => "Name",
        :study_id => 1
      )
    ])
  end

  it "renders a list of segments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end

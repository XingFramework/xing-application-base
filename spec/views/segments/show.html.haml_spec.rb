require 'spec_helper'

describe "segments/show" do
  before(:each) do
    @segment = assign(:segment, stub_model(Segment,
      :name => "Name",
      :study_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end

require 'spec_helper'

describe "delayed_jobs/index" do
  before(:each) do
    assign(:delayed_jobs, [
      stub_model(DelayedJob,
        :priority => 1,
        :attempts => 2,
        :handler => "MyText",
        :last_error => "MyText",
        :locked_by => "Locked By",
        :queue => "Queue"
      ),
      stub_model(DelayedJob,
        :priority => 1,
        :attempts => 2,
        :handler => "MyText",
        :last_error => "MyText",
        :locked_by => "Locked By",
        :queue => "Queue"
      )
    ])
  end

  it "renders a list of delayed_jobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Locked By".to_s, :count => 2
    assert_select "tr>td", :text => "Queue".to_s, :count => 2
  end
end

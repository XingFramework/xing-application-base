require 'spec_helper'

describe "delayed_jobs/show" do
  before(:each) do
    @delayed_job = assign(:delayed_job, stub_model(DelayedJob,
      :priority => 1,
      :attempts => 2,
      :handler => "MyText",
      :last_error => "MyText",
      :locked_by => "Locked By",
      :queue => "Queue"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Locked By/)
    rendered.should match(/Queue/)
  end
end

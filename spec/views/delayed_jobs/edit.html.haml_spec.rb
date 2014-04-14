require 'spec_helper'

describe "delayed_jobs/edit" do
  before(:each) do
    @delayed_job = assign(:delayed_job, stub_model(DelayedJob,
      :priority => 1,
      :attempts => 1,
      :handler => "MyText",
      :last_error => "MyText",
      :locked_by => "MyString",
      :queue => "MyString"
    ))
  end

  it "renders the edit delayed_job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", delayed_job_path(@delayed_job), "post" do
      assert_select "input#delayed_job_priority[name=?]", "delayed_job[priority]"
      assert_select "input#delayed_job_attempts[name=?]", "delayed_job[attempts]"
      assert_select "textarea#delayed_job_handler[name=?]", "delayed_job[handler]"
      assert_select "textarea#delayed_job_last_error[name=?]", "delayed_job[last_error]"
      assert_select "input#delayed_job_locked_by[name=?]", "delayed_job[locked_by]"
      assert_select "input#delayed_job_queue[name=?]", "delayed_job[queue]"
    end
  end
end

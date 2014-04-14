require 'spec_helper'

describe "study_applications/show" do
  before(:each) do
    @study_application = assign(:study_application, stub_model(StudyApplication,
      :study_id => 1,
      :consumer_id => 2,
      :segment_id => 3,
      :status => 4,
      :dispute_reason => "MyText",
      :inviter_id => 5,
      :referrer_id => 6,
      :refute_reason => "Refute Reason",
      :referral_email => "Referral Email",
      :token => "Token"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/MyText/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/Refute Reason/)
    rendered.should match(/Referral Email/)
    rendered.should match(/Token/)
  end
end

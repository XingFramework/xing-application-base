require 'spec_helper'

describe "study_applications/index" do
  before(:each) do
    assign(:study_applications, [
      stub_model(StudyApplication,
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
      ),
      stub_model(StudyApplication,
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
      )
    ])
  end

  it "renders a list of study_applications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "Refute Reason".to_s, :count => 2
    assert_select "tr>td", :text => "Referral Email".to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
  end
end

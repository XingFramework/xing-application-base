require 'spec_helper'

describe "study_applications/new" do
  before(:each) do
    assign(:study_application, stub_model(StudyApplication,
      :study_id => 1,
      :consumer_id => 1,
      :segment_id => 1,
      :status => 1,
      :dispute_reason => "MyText",
      :inviter_id => 1,
      :referrer_id => 1,
      :refute_reason => "MyString",
      :referral_email => "MyString",
      :token => "MyString"
    ).as_new_record)
  end

  it "renders new study_application form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", study_applications_path, "post" do
      assert_select "input#study_application_study_id[name=?]", "study_application[study_id]"
      assert_select "input#study_application_consumer_id[name=?]", "study_application[consumer_id]"
      assert_select "input#study_application_segment_id[name=?]", "study_application[segment_id]"
      assert_select "input#study_application_status[name=?]", "study_application[status]"
      assert_select "textarea#study_application_dispute_reason[name=?]", "study_application[dispute_reason]"
      assert_select "input#study_application_inviter_id[name=?]", "study_application[inviter_id]"
      assert_select "input#study_application_referrer_id[name=?]", "study_application[referrer_id]"
      assert_select "input#study_application_refute_reason[name=?]", "study_application[refute_reason]"
      assert_select "input#study_application_referral_email[name=?]", "study_application[referral_email]"
      assert_select "input#study_application_token[name=?]", "study_application[token]"
    end
  end
end

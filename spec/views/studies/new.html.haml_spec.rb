require 'spec_helper'

describe "studies/new" do
  before(:each) do
    assign(:study, stub_model(Study,
      :title => "MyString",
      :notes => "MyText",
      :quota => 1,
      :duration => 1,
      :gender_m => false,
      :gender_f => false,
      :age_from => 1,
      :age_to => 1,
      :researcher_id => 1,
      :status => 1,
      :states => "MyText",
      :countries => "MyText",
      :regions => "MyText",
      :internal_title => "MyString",
      :seats_left => 1,
      :admin => false,
      :token => "MyString",
      :admin_fee => 1,
      :application_fee => 1,
      :pay_rate => 1,
      :private => false,
      :logo_url => "MyString",
      :token_secret => "MyString",
      :language => "MyString",
      :platform_web => false,
      :platform_ios => false,
      :platform_android => false,
      :pre_accepted_emails => "MyText",
      :single_serve => false,
      :transcribe => false,
      :acceptance_email_copy => "MyText",
      :acceptance_email_pdf => "MyString"
    ).as_new_record)
  end

  it "renders new study form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", studies_path, "post" do
      assert_select "input#study_title[name=?]", "study[title]"
      assert_select "textarea#study_notes[name=?]", "study[notes]"
      assert_select "input#study_quota[name=?]", "study[quota]"
      assert_select "input#study_duration[name=?]", "study[duration]"
      assert_select "input#study_gender_m[name=?]", "study[gender_m]"
      assert_select "input#study_gender_f[name=?]", "study[gender_f]"
      assert_select "input#study_age_from[name=?]", "study[age_from]"
      assert_select "input#study_age_to[name=?]", "study[age_to]"
      assert_select "input#study_researcher_id[name=?]", "study[researcher_id]"
      assert_select "input#study_status[name=?]", "study[status]"
      assert_select "textarea#study_states[name=?]", "study[states]"
      assert_select "textarea#study_countries[name=?]", "study[countries]"
      assert_select "textarea#study_regions[name=?]", "study[regions]"
      assert_select "input#study_internal_title[name=?]", "study[internal_title]"
      assert_select "input#study_seats_left[name=?]", "study[seats_left]"
      assert_select "input#study_admin[name=?]", "study[admin]"
      assert_select "input#study_token[name=?]", "study[token]"
      assert_select "input#study_admin_fee[name=?]", "study[admin_fee]"
      assert_select "input#study_application_fee[name=?]", "study[application_fee]"
      assert_select "input#study_pay_rate[name=?]", "study[pay_rate]"
      assert_select "input#study_private[name=?]", "study[private]"
      assert_select "input#study_logo_url[name=?]", "study[logo_url]"
      assert_select "input#study_token_secret[name=?]", "study[token_secret]"
      assert_select "input#study_language[name=?]", "study[language]"
      assert_select "input#study_platform_web[name=?]", "study[platform_web]"
      assert_select "input#study_platform_ios[name=?]", "study[platform_ios]"
      assert_select "input#study_platform_android[name=?]", "study[platform_android]"
      assert_select "textarea#study_pre_accepted_emails[name=?]", "study[pre_accepted_emails]"
      assert_select "input#study_single_serve[name=?]", "study[single_serve]"
      assert_select "input#study_transcribe[name=?]", "study[transcribe]"
      assert_select "textarea#study_acceptance_email_copy[name=?]", "study[acceptance_email_copy]"
      assert_select "input#study_acceptance_email_pdf[name=?]", "study[acceptance_email_pdf]"
    end
  end
end

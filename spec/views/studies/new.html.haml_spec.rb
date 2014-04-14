require 'spec_helper'

describe "studies/new" do
  before(:each) do
    assign(:studie, stub_model(Studie,
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

  it "renders new studie form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", studies_path, "post" do
      assert_select "input#studie_title[name=?]", "studie[title]"
      assert_select "textarea#studie_notes[name=?]", "studie[notes]"
      assert_select "input#studie_quota[name=?]", "studie[quota]"
      assert_select "input#studie_duration[name=?]", "studie[duration]"
      assert_select "input#studie_gender_m[name=?]", "studie[gender_m]"
      assert_select "input#studie_gender_f[name=?]", "studie[gender_f]"
      assert_select "input#studie_age_from[name=?]", "studie[age_from]"
      assert_select "input#studie_age_to[name=?]", "studie[age_to]"
      assert_select "input#studie_researcher_id[name=?]", "studie[researcher_id]"
      assert_select "input#studie_status[name=?]", "studie[status]"
      assert_select "textarea#studie_states[name=?]", "studie[states]"
      assert_select "textarea#studie_countries[name=?]", "studie[countries]"
      assert_select "textarea#studie_regions[name=?]", "studie[regions]"
      assert_select "input#studie_internal_title[name=?]", "studie[internal_title]"
      assert_select "input#studie_seats_left[name=?]", "studie[seats_left]"
      assert_select "input#studie_admin[name=?]", "studie[admin]"
      assert_select "input#studie_token[name=?]", "studie[token]"
      assert_select "input#studie_admin_fee[name=?]", "studie[admin_fee]"
      assert_select "input#studie_application_fee[name=?]", "studie[application_fee]"
      assert_select "input#studie_pay_rate[name=?]", "studie[pay_rate]"
      assert_select "input#studie_private[name=?]", "studie[private]"
      assert_select "input#studie_logo_url[name=?]", "studie[logo_url]"
      assert_select "input#studie_token_secret[name=?]", "studie[token_secret]"
      assert_select "input#studie_language[name=?]", "studie[language]"
      assert_select "input#studie_platform_web[name=?]", "studie[platform_web]"
      assert_select "input#studie_platform_ios[name=?]", "studie[platform_ios]"
      assert_select "input#studie_platform_android[name=?]", "studie[platform_android]"
      assert_select "textarea#studie_pre_accepted_emails[name=?]", "studie[pre_accepted_emails]"
      assert_select "input#studie_single_serve[name=?]", "studie[single_serve]"
      assert_select "input#studie_transcribe[name=?]", "studie[transcribe]"
      assert_select "textarea#studie_acceptance_email_copy[name=?]", "studie[acceptance_email_copy]"
      assert_select "input#studie_acceptance_email_pdf[name=?]", "studie[acceptance_email_pdf]"
    end
  end
end

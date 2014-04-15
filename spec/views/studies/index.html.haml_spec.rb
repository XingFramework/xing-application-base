require 'spec_helper'

describe "studies/index" do
  before(:each) do
    assign(:studies, [
      stub_model(Study,
        :title => "Title",
        :notes => "MyText",
        :quota => 1,
        :duration => 2,
        :gender_m => false,
        :gender_f => false,
        :age_from => 3,
        :age_to => 4,
        :researcher_id => 5,
        :status => 6,
        :states => "MyText",
        :countries => "MyText",
        :regions => "MyText",
        :internal_title => "Internal Title",
        :seats_left => 7,
        :admin => false,
        :token => "Token",
        :admin_fee => 8,
        :application_fee => 9,
        :pay_rate => 10,
        :private => false,
        :logo_url => "Logo Url",
        :token_secret => "Token Secret",
        :language => "Language",
        :platform_web => false,
        :platform_ios => false,
        :platform_android => false,
        :pre_accepted_emails => "MyText",
        :single_serve => false,
        :transcribe => false,
        :acceptance_email_copy => "MyText",
        :acceptance_email_pdf => "Acceptance Email Pdf"
      ),
      stub_model(Study,
        :title => "Title",
        :notes => "MyText",
        :quota => 1,
        :duration => 2,
        :gender_m => false,
        :gender_f => false,
        :age_from => 3,
        :age_to => 4,
        :researcher_id => 5,
        :status => 6,
        :states => "MyText",
        :countries => "MyText",
        :regions => "MyText",
        :internal_title => "Internal Title",
        :seats_left => 7,
        :admin => false,
        :token => "Token",
        :admin_fee => 8,
        :application_fee => 9,
        :pay_rate => 10,
        :private => false,
        :logo_url => "Logo Url",
        :token_secret => "Token Secret",
        :language => "Language",
        :platform_web => false,
        :platform_ios => false,
        :platform_android => false,
        :pre_accepted_emails => "MyText",
        :single_serve => false,
        :transcribe => false,
        :acceptance_email_copy => "MyText",
        :acceptance_email_pdf => "Acceptance Email Pdf"
      )
    ])
  end

  it "renders a list of studies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Internal Title".to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Logo Url".to_s, :count => 2
    assert_select "tr>td", :text => "Token Secret".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Acceptance Email Pdf".to_s, :count => 2
  end
end

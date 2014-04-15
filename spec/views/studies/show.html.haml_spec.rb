require 'spec_helper'

describe "studies/show" do
  before(:each) do
    @study = assign(:study, stub_model(Study,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Internal Title/)
    rendered.should match(/7/)
    rendered.should match(/false/)
    rendered.should match(/Token/)
    rendered.should match(/8/)
    rendered.should match(/9/)
    rendered.should match(/10/)
    rendered.should match(/false/)
    rendered.should match(/Logo Url/)
    rendered.should match(/Token Secret/)
    rendered.should match(/Language/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/MyText/)
    rendered.should match(/Acceptance Email Pdf/)
  end
end

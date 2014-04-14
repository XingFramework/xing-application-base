require 'spec_helper'

describe "videos/show" do
  before(:each) do
    @video = assign(:video, stub_model(Video,
      :owner_id => 1,
      :owner_type => "Owner Type",
      :status => 2,
      :camatar_flv_url => "Camatar Flv Url",
      :camatar_image_url => "Camatar Image Url",
      :camatar_thumb_url => "Camatar Thumb Url",
      :camatar_token => "Camatar Token",
      :camatar_duration => 3,
      :camatar_max_duration => 4,
      :token => "Token",
      :transcoded_url => "Transcoded Url",
      :filename => "Filename",
      :zencoder_job_id => "Zencoder Job",
      :uploaded_filename => "Uploaded Filename",
      :upload_duration => 5,
      :transcript_upload_url => "Transcript Upload Url",
      :transcript_record_id => "Transcript Record",
      :transcript_text => "MyText",
      :custom_text => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Owner Type/)
    rendered.should match(/2/)
    rendered.should match(/Camatar Flv Url/)
    rendered.should match(/Camatar Image Url/)
    rendered.should match(/Camatar Thumb Url/)
    rendered.should match(/Camatar Token/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/Token/)
    rendered.should match(/Transcoded Url/)
    rendered.should match(/Filename/)
    rendered.should match(/Zencoder Job/)
    rendered.should match(/Uploaded Filename/)
    rendered.should match(/5/)
    rendered.should match(/Transcript Upload Url/)
    rendered.should match(/Transcript Record/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end

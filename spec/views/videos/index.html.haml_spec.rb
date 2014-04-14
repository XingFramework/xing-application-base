require 'spec_helper'

describe "videos/index" do
  before(:each) do
    assign(:videos, [
      stub_model(Video,
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
      ),
      stub_model(Video,
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
      )
    ])
  end

  it "renders a list of videos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Owner Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Camatar Flv Url".to_s, :count => 2
    assert_select "tr>td", :text => "Camatar Image Url".to_s, :count => 2
    assert_select "tr>td", :text => "Camatar Thumb Url".to_s, :count => 2
    assert_select "tr>td", :text => "Camatar Token".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
    assert_select "tr>td", :text => "Transcoded Url".to_s, :count => 2
    assert_select "tr>td", :text => "Filename".to_s, :count => 2
    assert_select "tr>td", :text => "Zencoder Job".to_s, :count => 2
    assert_select "tr>td", :text => "Uploaded Filename".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Transcript Upload Url".to_s, :count => 2
    assert_select "tr>td", :text => "Transcript Record".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

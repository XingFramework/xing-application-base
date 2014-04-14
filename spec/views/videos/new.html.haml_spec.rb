require 'spec_helper'

describe "videos/new" do
  before(:each) do
    assign(:video, stub_model(Video,
      :owner_id => 1,
      :owner_type => "MyString",
      :status => 1,
      :camatar_flv_url => "MyString",
      :camatar_image_url => "MyString",
      :camatar_thumb_url => "MyString",
      :camatar_token => "MyString",
      :camatar_duration => 1,
      :camatar_max_duration => 1,
      :token => "MyString",
      :transcoded_url => "MyString",
      :filename => "MyString",
      :zencoder_job_id => "MyString",
      :uploaded_filename => "MyString",
      :upload_duration => 1,
      :transcript_upload_url => "MyString",
      :transcript_record_id => "MyString",
      :transcript_text => "MyText",
      :custom_text => "MyText"
    ).as_new_record)
  end

  it "renders new video form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", videos_path, "post" do
      assert_select "input#video_owner_id[name=?]", "video[owner_id]"
      assert_select "input#video_owner_type[name=?]", "video[owner_type]"
      assert_select "input#video_status[name=?]", "video[status]"
      assert_select "input#video_camatar_flv_url[name=?]", "video[camatar_flv_url]"
      assert_select "input#video_camatar_image_url[name=?]", "video[camatar_image_url]"
      assert_select "input#video_camatar_thumb_url[name=?]", "video[camatar_thumb_url]"
      assert_select "input#video_camatar_token[name=?]", "video[camatar_token]"
      assert_select "input#video_camatar_duration[name=?]", "video[camatar_duration]"
      assert_select "input#video_camatar_max_duration[name=?]", "video[camatar_max_duration]"
      assert_select "input#video_token[name=?]", "video[token]"
      assert_select "input#video_transcoded_url[name=?]", "video[transcoded_url]"
      assert_select "input#video_filename[name=?]", "video[filename]"
      assert_select "input#video_zencoder_job_id[name=?]", "video[zencoder_job_id]"
      assert_select "input#video_uploaded_filename[name=?]", "video[uploaded_filename]"
      assert_select "input#video_upload_duration[name=?]", "video[upload_duration]"
      assert_select "input#video_transcript_upload_url[name=?]", "video[transcript_upload_url]"
      assert_select "input#video_transcript_record_id[name=?]", "video[transcript_record_id]"
      assert_select "textarea#video_transcript_text[name=?]", "video[transcript_text]"
      assert_select "textarea#video_custom_text[name=?]", "video[custom_text]"
    end
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    owner_id 1
    owner_type "MyString"
    status 1
    camatar_flv_url "MyString"
    camatar_image_url "MyString"
    camatar_thumb_url "MyString"
    camatar_token "MyString"
    camatar_duration 1
    camatar_max_duration 1
    token "MyString"
    transcoded_url "MyString"
    transcoded_at "2014-04-14 15:20:56"
    created_at "2014-04-14 15:20:56"
    updated_at "2014-04-14 15:20:56"
    filename "MyString"
    zencoder_job_id "MyString"
    zencoder_finished_at "2014-04-14 15:20:56"
    uploaded_filename "MyString"
    upload_duration 1
    transcript_upload_url "MyString"
    transcript_record_id "MyString"
    transcript_text "MyText"
    custom_text "MyText"
  end
end

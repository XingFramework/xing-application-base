json.array!(@videos) do |video|
  json.extract! video, :id, :owner_id, :owner_type, :status, :camatar_flv_url, :camatar_image_url, :camatar_thumb_url, :camatar_token, :camatar_duration, :camatar_max_duration, :token, :transcoded_url, :transcoded_at, :created_at, :updated_at, :filename, :zencoder_job_id, :zencoder_finished_at, :uploaded_filename, :upload_duration, :transcript_upload_url, :transcript_record_id, :transcript_text, :custom_text
  json.url video_url(video, format: :json)
end

json.array!(@study_questions) do |study_question|
  json.extract! study_question, :id, :text, :study_id, :attachment_file_name, :attachment_content_type, :attachment_file_size, :attachment_updated_at, :embed, :created_at, :updated_at
  json.url study_question_url(study_question, format: :json)
end

json.array!(@study_answers) do |study_answer|
  json.extract! study_answer, :id, :study_question_id, :study_application_id, :created_at, :updated_at, :latitude, :longitude
  json.url study_answer_url(study_answer, format: :json)
end

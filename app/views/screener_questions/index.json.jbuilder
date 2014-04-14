json.array!(@screener_questions) do |screener_question|
  json.extract! screener_question, :id, :text, :options, :study_id, :created_at, :updated_at, :answer_type
  json.url screener_question_url(screener_question, format: :json)
end

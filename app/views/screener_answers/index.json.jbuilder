json.array!(@screener_answers) do |screener_answer|
  json.extract! screener_answer, :id, :text, :study_application_id, :screener_question_id, :rating, :created_at, :updated_at
  json.url screener_answer_url(screener_answer, format: :json)
end

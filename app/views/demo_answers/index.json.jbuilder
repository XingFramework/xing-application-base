json.array!(@demo_answers) do |demo_answer|
  json.extract! demo_answer, :id, :text, :position, :demo_question_id, :created_at, :updated_at
  json.url demo_answer_url(demo_answer, format: :json)
end

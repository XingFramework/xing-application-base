json.array!(@demo_questions) do |demo_question|
  json.extract! demo_question, :id, :text, :caption, :position, :multiple, :created_at, :updated_at
  json.url demo_question_url(demo_question, format: :json)
end

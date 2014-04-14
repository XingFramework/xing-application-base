json.array!(@demo_responses) do |demo_response|
  json.extract! demo_response, :id, :user_id, :demo_answer_id, :created_at, :updated_at
  json.url demo_response_url(demo_response, format: :json)
end

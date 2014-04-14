json.array!(@tutorials) do |tutorial|
  json.extract! tutorial, :id, :title, :user_type, :created_at, :updated_at
  json.url tutorial_url(tutorial, format: :json)
end

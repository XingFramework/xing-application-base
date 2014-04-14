json.array!(@consumer_researchers) do |consumer_researcher|
  json.extract! consumer_researcher, :id, :consumer_id, :researcher_id, :created_at, :updated_at
  json.url consumer_researcher_url(consumer_researcher, format: :json)
end

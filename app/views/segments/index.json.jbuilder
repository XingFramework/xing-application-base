json.array!(@segments) do |segment|
  json.extract! segment, :id, :name, :study_id, :created_at, :updated_at
  json.url segment_url(segment, format: :json)
end

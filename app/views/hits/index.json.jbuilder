json.array!(@hits) do |hit|
  json.extract! hit, :id, :user_id, :ip, :request, :params, :created_at, :updated_at
  json.url hit_url(hit, format: :json)
end

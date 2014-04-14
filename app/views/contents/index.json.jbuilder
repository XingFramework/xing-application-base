json.array!(@contents) do |content|
  json.extract! content, :id, :name, :group, :text, :created_at, :updated_at
  json.url content_url(content, format: :json)
end

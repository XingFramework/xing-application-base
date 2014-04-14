json.array!(@synonyms) do |synonym|
  json.extract! synonym, :id, :name, :tag_id, :created_at, :updated_at
  json.url synonym_url(synonym, format: :json)
end

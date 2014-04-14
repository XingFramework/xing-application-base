json.array!(@taggings) do |tagging|
  json.extract! tagging, :id, :tag_id, :taggable_id, :taggable_type, :tagger_id, :tagger_type, :context, :created_at
  json.url tagging_url(tagging, format: :json)
end

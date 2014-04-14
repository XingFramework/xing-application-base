json.array!(@access_tokens) do |access_token|
  json.extract! access_token, :id, :user_id, :email, :token, :created_at, :updated_at, :type
  json.url access_token_url(access_token, format: :json)
end

json.array!(@researcher_interests) do |researcher_interest|
  json.extract! researcher_interest, :id, :first_name, :last_name, :email, :phone, :company_name, :created_at, :updated_at
  json.url researcher_interest_url(researcher_interest, format: :json)
end

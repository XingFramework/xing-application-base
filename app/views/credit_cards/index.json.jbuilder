json.array!(@credit_cards) do |credit_card|
  json.extract! credit_card, :id, :researcher_id, :first_name, :last_name, :number, :month, :year, :ctype, :cvv, :address1, :address2, :city, :state, :country, :zip, :created_at, :updated_at, :reference_transaction
  json.url credit_card_url(credit_card, format: :json)
end

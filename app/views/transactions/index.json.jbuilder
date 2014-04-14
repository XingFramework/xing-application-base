json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :what_id, :what_type, :amount, :note, :created_at, :updated_at, :user_id, :payment_method, :reference, :authorization, :study_id, :category
  json.url transaction_url(transaction, format: :json)
end

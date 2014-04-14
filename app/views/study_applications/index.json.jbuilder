json.array!(@study_applications) do |study_application|
  json.extract! study_application, :id, :study_id, :consumer_id, :segment_id, :status, :accepted_or_declined_at, :started_at, :completed_at, :payed_at, :disputed_at, :dispute_reason, :created_at, :updated_at, :inviter_id, :applied_at, :referrer_id, :refute_reason, :refuted_at, :referral_email, :token, :notified_full_at
  json.url study_application_url(study_application, format: :json)
end

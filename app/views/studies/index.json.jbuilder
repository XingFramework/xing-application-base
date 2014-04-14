json.array!(@studies) do |study|
  json.extract! study, :id, :title, :notes, :quota, :duration, :start_at, :end_at, :gender_m, :gender_f, :age_from, :age_to, :researcher_id, :created_at, :updated_at, :status, :states, :countries, :regions, :internal_title, :seats_left, :admin, :token, :admin_fee, :application_fee, :pay_rate, :private, :logo_url, :token_secret, :language, :platform_web, :platform_ios, :platform_android, :pre_accepted_emails, :single_serve, :transcribe, :acceptance_email_copy, :acceptance_email_pdf
  json.url study_url(study, format: :json)
end

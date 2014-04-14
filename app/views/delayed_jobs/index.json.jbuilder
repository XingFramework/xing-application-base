json.array!(@delayed_jobs) do |delayed_job|
  json.extract! delayed_job, :id, :priority, :attempts, :handler, :last_error, :run_at, :locked_at, :failed_at, :locked_by, :created_at, :updated_at, :queue
  json.url delayed_job_url(delayed_job, format: :json)
end

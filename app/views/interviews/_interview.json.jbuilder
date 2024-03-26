json.extract! interview, :id, :interview_type, :details, :start_date, :end_date, :point, :job_listing_id, :created_at, :updated_at
json.url interview_url(interview, format: :json)

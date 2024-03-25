json.extract! job_listing, :id, :title, :company, :location, :salary, :status, :details, :details_summary, :applicant_id, :points, :board_id, :created_at, :updated_at
json.url job_listing_url(job_listing, format: :json)

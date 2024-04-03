json.extract! ai_message, :id, :role, :body, :job_listing_id, :created_at, :updated_at
json.url ai_message_url(ai_message, format: :json)

json.extract! session, :id, :name, :start_time, :created_at, :updated_at
json.url session_url(session, format: :json)

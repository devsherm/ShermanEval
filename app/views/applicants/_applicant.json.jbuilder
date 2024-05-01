json.extract! applicant, :id, :user_id, :name, :experience, :availability, :created_at, :updated_at
json.url applicant_url(applicant, format: :json)

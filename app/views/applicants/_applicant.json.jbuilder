json.extract! applicant, :id, :user_id, :my_level, :full_time, :fav_pet, :created_at, :updated_at
json.url applicant_url(applicant, format: :json)

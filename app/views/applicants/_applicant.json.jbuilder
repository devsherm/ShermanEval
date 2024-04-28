json.extract! applicant, :id, :user_id, :my_level, :scratch_before, :fav_hobby, :created_at, :updated_at
json.url applicant_url(applicant, format: :json)

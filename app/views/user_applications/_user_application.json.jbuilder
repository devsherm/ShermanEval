json.extract! user_application, :id, :first_name, :last_name, :user_id, :skills, :about_me, :gender, :score, :created_at, :updated_at
json.url user_application_url(user_application, format: :json)

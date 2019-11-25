json.extract! user, :id, :first_name, :last_name, :is_admin, :is_professor, :student_id, :created_at, :updated_at
json.url user_url(user, format: :json)

json.extract! student, :id, :major, :gpa, :created_at, :updated_at
json.url student_url(student, format: :json)

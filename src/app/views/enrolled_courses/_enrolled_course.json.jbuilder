json.extract! enrolled_course, :id, :student_id, :course_id, :created_at, :updated_at
json.url enrolled_course_url(enrolled_course, format: :json)

json.extract! course, :id, :course_id, :course_title, :description, :professor_id, :minimum_seats, :maximum_seats, :seats_taken, :created_at, :updated_at
json.url course_url(course, format: :json)

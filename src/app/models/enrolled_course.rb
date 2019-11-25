# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: enrolled_course.rb
# Description: Model class for the enrollment records
# Last modified on: 11/24/19

class EnrolledCourse < ApplicationRecord
  #Associations
  belongs_to :student
  belongs_to :course

  #Validations
  validates :student_id, uniqueness: { scope: :course_id,
    message: "cannot enroll into the same course twice!" }
  
  #Functions
  #  Function: check_waitlist_records
  #    Parameters: None
  #    Pre-condition: The course enrollment record is created. 
  #    Post-condition: Returns the list of waitlist entries that match 
  #                    the enrollment record's attributes.
  def check_waitlist_records
    Waitlist.where(course_id: course_id, student_id: student_id)
  end
end

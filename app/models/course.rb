# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: course.rb
# Description: Model class for the courses
# Last modified on: 11/24/19

class Course < ApplicationRecord
  #Associations
  belongs_to :user
  
  has_many :enrolled_courses, dependent: :destroy
  has_many :students, through: :enrolled_courses

  #Validations
  validates :course_id, presence: true, length: {in: 8..10},
    format: { with: /\A[a-z\d][a-z\d-]*[a-z\d]\z/i.freeze }, uniqueness: { case_sensitive: false }
    
    validates :course_title, presence: true, length: {in: 1..100},
    format: { with: /\A[a-zA-Z ]+\z/.freeze }
    
    validates :description, presence: true, length: { minimum: 20 }, confirmation: { case_sensitive: true }
    
    validates :minimum_seats, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :maximum_seats, presence: true,
      numericality: { greater_than_or_equal_to: :minimum_seats, only_integer: true }

    validates :seats_taken, presence: true,
      numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: :maximum_seats, only_integer: true }
  
  #Functions

  #  Function: show_roster
  #    Parameters: None
  #    Pre-condition: The course is created. 
  #    Post-condition: Returns the list of students that are enrolled in the course.
  def show_roster
    EnrolledCourse.where(course: self).order(:course_id).map(&:student)
  end

  #  Function: show_students_on_waitlist
  #    Parameters: None
  #    Pre-condition: The course is created. 
  #    Post-condition: Returns the list of students that are on the waitlist for the course.
  def show_students_on_waitlist
    Waitlist.where(course: self).order(:course_id).map(&:student)
  end
  
  #  Function: course_title_with_id
  #    Parameters: None
  #    Pre-condition: The course is created. 
  #    Post-condition: Returns the string containing the ID and course title
  def course_title_with_id
    course_id + " " + course_title
  end

  #  Function: seats_available
  #    Parameters: None
  #    Pre-condition: The course is created. 
  #    Post-condition: Returns the number of available seats for the course.
  def seats_available
    maximum_seats - EnrolledCourse.where(course_id: id).count
  end
end

# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: student.rb
# Description: Model class for the students
# Last modified on: 11/24/19

class Student < ApplicationRecord
    #Associations
    belongs_to :user, optional: false

    has_many :enrolled_courses, dependent: :destroy
    has_many :courses, through: :enrolled_courses

    has_many :waitlists, dependent: :destroy
    has_many :courses, through: :waitlists

    has_many :course_histories, dependent: :destroy
    has_many :courses, through: :course_histories

    #Validations
    validates :gpa, presence: true, numericality: {greater_than_or_equal_to: 0.0, less_than_or_equal_to: 4.0}
    

    #Functions

    #  Function: full_name_with_id
    #    Parameters: None
    #    Pre-condition: The student account is created. 
    #    Post-condition: Returns a string containing the ID, first name, and
    #                    last name of the student in that order.
    def full_name_with_id
      id.to_s + ": " + user.first_name + " " + user.last_name
    end

    #  Function: show_enrolled_courses
    #    Parameters: None
    #    Pre-condition: The student account is created. 
    #    Post-condition: Returns the list of courses the student is enrolled in.
    def show_enrolled_courses
      EnrolledCourse.where(student: self).order(:course_id).map(&:course)
    end

    #  Function: show_courses_on_waitlist
    #    Parameters: None
    #    Pre-condition: The student account is created. 
    #    Post-condition: Returns the list of courses the student has waitlisted for.
    def show_courses_on_waitlist
      Waitlist.where(student: self).order(:course_id).map(&:student)
    end
end
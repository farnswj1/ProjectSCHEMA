# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: course_history.rb
# Description: Model superclass for the course history class
# Last modified on: 11/24/19

class CourseHistory < ApplicationRecord
  #Associations
  belongs_to :student
  belongs_to :course

  #Validations
  validates :password, presence: true, 
    inclusion: {in: ['A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F']}, 
    length: { in: 1..2 }, confirmation: { case_sensitive: true }
end

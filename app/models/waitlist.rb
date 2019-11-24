# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: waitlist.rb
# Description: Model class for the waitlist entries
# Last modified on: 11/24/19

class Waitlist < ApplicationRecord
  #Associations
  belongs_to :student
  belongs_to :course

  #Validations
  validates :student_id, uniqueness: { scope: :course_id,
    message: "cannot be on the waitlist for the same course twice!" }
end

# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: user.rb
# Description: Model class for the users
# Last modified on: 11/24/19

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #Associations
  belongs_to :student, dependent: :destroy, optional: true
  
  #Validations
  validates :first_name, presence: true, length: {in: 1..25},
  format: { with: /\A[a-zA-Z']+\z/.freeze }
  
  validates :last_name, presence: true, length: {in: 1..50},
  format: { with: /\A[a-zA-Z' -]+\z/.freeze }
  
  validates :password, presence: true, length: { minimum: 8 }, confirmation: { case_sensitive: true }, on: :create
  
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze },
  uniqueness: { case_sensitive: false }

  #Functions

  #  Function: full_name
  #    Parameters: None
  #    Pre-condition: The user account is created. 
  #    Post-condition: Returns a string containing the full name of the student.
  def full_name
    first_name + " " + last_name
  end

  #  Function: full_name_with_id
  #    Parameters: None
  #    Pre-condition: The user account is created. 
  #    Post-condition: Returns a string containing the ID, first name, and
  #                    last name of the user in that order.
  def full_name_with_id
      id.to_s + ": " + first_name + " " + last_name
  end

  #  Function: is_student?
  #    Parameters: None
  #    Pre-condition: The student account is created. 
  #    Post-condition: Returns a boolean: true if user has a student account, false otherwise.
  def is_student?
    student.nil?
  end

  #  Function: save_student_profile(id)
  #    Parameters: id
  #    Pre-condition: The user account is created. 
  #    Post-condition: Saves the student ID to the user.
  def save_student_profile(id)
    student = id
  end

  #  Function: save_student_profile(id)
  #    Parameters: id
  #    Pre-condition: The user account is created and the user is a professor. 
  #    Post-condition: Returns a list of courses the professor is instructing.
  def show_courses_instructing
    if is_professor?
      Course.where(user_id: self).order(:course_id)
    end
  end
end

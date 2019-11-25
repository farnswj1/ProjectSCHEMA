# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: students_controller.rb
# Description: Controller class for user the students
# Last modified on: 11/24/19

class StudentsController < ApplicationController
  before_action :set_student, only: [:edit, :update, :destroy]
  skip_before_action :check_student_registration, only: [:new, :create]
  before_action :check_user_permissions, only: [:edit, :update, :destroy]

  #  Function: check_user_permissions
  #    Parameters: None
  #    Pre-condition: The user must be logged in.
  #    Post-condition: The user is directed to dashboard page if they're not an admin or professor.
  #                    Otherwise, no redirects are made.
  def check_user_permissions
    if user_signed_in?
      if !current_user.is_admin? && !current_user.is_professor?
          redirect_to home_dashboard_path, notice: "You don't have permission to access that page!"
      end
    end
  end

  #  Function: new
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be a student.
  #    Post-condition: The user is redirected to a form to fill out for the new student account.
  def new
    @student = Student.new
  end

  #  Function: edit
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be either an admin or professor.
  #    Post-condition: The user is redirected to a form to fill out any changes for the student account.
  def edit
  end

  #  Function: create
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be a student. Also, the form for the new
  #                   student account is filled out and passes all validations
  #    Post-condition: The student account is created and saved into the database.
  #                    Then the student is redirected to the dashboard.
  def create
    @student = Student.new(student_params)
    #@user = current_user
    @student.user = current_user
    current_user.student = @student

    respond_to do |format|
      if current_user.student_id.nil?
        if @student.save && current_user.update_attribute(:student, @student)
          format.html { redirect_to home_dashboard_path, notice: 'Student Profile was successfully created!' }
          format.json { render :show, status: :created, location: @student }
        else
          format.html { render :new }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to home_dashboard_path, notice: 'You already have a student profile!'}
      end
    end
  end

  #  Function: update
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be either an admin. Also, the form 
  #                   for the course is filled out and passes all validations.
  #    Post-condition: The changes to the student account are made and saved into the database.
  #                    Then the admin is redirected to the Student Information page for the new course.
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  #  Function: destroy
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be an admin.
  #    Post-condition: The student account is deleted from the database. Then the admin is redirected
  #                    to the User Accounts page.
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to users-path, notice: 'Student account was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    #  Function: set_student
    #    Parameters: None
    #    Pre-condition: The user must be logged in.
    #    Post-condition: The student account is retrieved from the database.
    def set_student
      @student = Student.find(params[:id])
    end

    #  Function: student_params
    #    Parameters: None
    #    Pre-condition: The user must be logged in.
    #    Post-condition: The params passed into the students controller are accepted.
    def student_params
      params.require(:student).permit(:major, :gpa)
    end
end

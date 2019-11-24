# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: courses_controller.rb
# Description: Controller class for the courses
# Last modified on: 11/24/19

class CoursesController < ApplicationController
  before_action :set_course, only: [:roster, :show, :edit, :update, :destroy]
  before_action :check_user_permissions, only: [:new, :create, :edit, :update, :destroy]
  
  #  Function: check_user_permissions
  #    Parameters: None
  #    Pre-condition: The user must be logged in.
  #    Post-condition: The user is directed to dashboard page if they're not an admin or professor.
  #                    Otherwise, no redirects are made.
  def check_user_permissions
    if user_signed_in?
      if !current_user.is_admin? && !current_user.is_professor?
          redirect_to courses_path, notice: "You don't have permission to access that page!"
      end
    end
  end

  #  Function: index
  #    Parameters: None
  #    Pre-condition: The user must be logged in.
  #    Post-condition: The user is redirected to the Course List page.
  def index
    @courses = Course.all
  end

  #  Function: show
  #    Parameters: None
  #    Pre-condition: The user must be logged in.
  #    Post-condition: The user is redirected to the Course Information page.
  def show
  end

  #  Function: roster
  #    Parameters: None
  #    Pre-condition: The user must be logged in.
  #    Post-condition: The user is redirected to the Course Roster page.
  def roster
  end

  #  Function: new
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be an admin.
  #    Post-condition: The user is redirected to a form to fill out for the new course.
  def new
    @course = Course.new
  end

  #  Function: edit
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be either an admin or professor.
  #    Post-condition: The user is redirected to a form to fill out any changes for the course.
  def edit
  end

  #  Function: create
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be an admin. Also, the form for the new
  #                   course is filled out and passes all validations
  #    Post-condition: The course is created and saved into the database.
  #                    Then the admin is redirected to the Course Information page for the new course.
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course ' + @course.course_id + ' was successfully created!' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  #  Function: update
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be either an admin or professor. Also, the form 
  #                   for the course is filled out and passes all validations.
  #    Post-condition: The changes to the course are made and saved into the database.
  #                    Then the admin is redirected to the Course Information page for the new course.
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course ' + @course.course_id + ' was successfully updated!' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  #  Function: destroy
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be an admin.
  #    Post-condition: The course is deleted from the database. Then the admin is redirected
  #                    to the Course Information page for the new course.
  def destroy
    course_name = @course.course_id
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course ' + course_name + ' was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    #  Function: set_course
    #    Parameters: None
    #    Pre-condition: The user must be logged in.
    #    Post-condition: The course is retrieved from the database.
    def set_course
      @course = Course.find(params[:id])
    end

    #  Function: course_params
    #    Parameters: None
    #    Pre-condition: The user must be logged in and be an admin.
    #    Post-condition: The params passed into the courses controller are accepted.
    def course_params
      params.require(:course).permit(:course_id, :course_title, :description, :user_id, :minimum_seats, :maximum_seats, :seats_taken)
    end
end

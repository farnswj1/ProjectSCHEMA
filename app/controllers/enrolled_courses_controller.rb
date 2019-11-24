# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: enrolled_courses_controller.rb
# Description: Controller class for enrollment records
# Last modified on: 11/24/19

class EnrolledCoursesController < ApplicationController
  before_action :set_enrolled_course, only: [:destroy]
  before_action :check_user_permissions, only: [:new]
  
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

  #  Function: new
  #    Parameters: None
  #    Pre-condition: The user must be logged in.
  #    Post-condition: The user is redirected to a form to fill out for enrolling.
  def new
    @enrolled_course = EnrolledCourse.new
  end

  #  Function: create
  #    Parameters: None
  #    Pre-condition: The user must be logged in.
  #    Post-condition: The enrollment record is created and saved into the database.
  #                    Then the user is redirected depending on their user type.
  def create
    @course = Course.find(enrolled_course_params[:course_id])
    if @course.seats_available <= 0
      redirect_to waitlists_path, notice: 'This course is already filled! No seats are currently available!'
    else
      @enrolled_course = EnrolledCourse.new(enrolled_course_params)

      if !current_user.is_admin? && !current_user.is_professor?
        @enrolled_course.student_id = current_user.student.id 
      else
        @student = Student.find(enrolled_course_params[:student_id])
      end

      respond_to do |format|
        if @enrolled_course.save
          waitlist_entry = @enrolled_course.check_waitlist_records
          if waitlist_entry.count > 0
            waitlist_entry.first.destroy
          end

          session[:my_previous_url] = URI(request.referer || '').path
        
          if session[:my_previous_url] == '/waitlists'
            if current_user.is_professor? || current_user.is_admin?
              format.html { redirect_to waitlists_path, notice: @student.user.first_name + ' ' + @student.user.last_name + ' was successfully enrolled into ' + @course.course_id + '!' }
              format.json { render :show, status: :created, location: @enrolled_course }
            else
              format.html { redirect_to home_dashboard_path, notice: 'You have successfully enrolled into ' + @course.course_id + '!' }
              format.json { render :show, status: :created, location: @enrolled_course }
            end
          else
            if current_user.is_professor? || current_user.is_admin?
              format.html { redirect_to home_dashboard_path, notice: @student.user.first_name + ' ' + @student.user.last_name + ' was successfully enrolled into ' + @course.course_id + '!' }
              format.json { render :show, status: :created, location: @enrolled_course }
            else
              format.html { redirect_to courses_path, notice: 'You have successfully enrolled into ' + @course.course_id + '!' }
              format.json { render :show, status: :created, location: @enrolled_course }
            end
          end
        else
          format.html { redirect_to @course }
          format.json { render json: @enrolled_course.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  #  Function: destroy
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be an admin or student.
  #    Post-condition: The record is deleted from the database. Then the admin is redirected
  #                    to the roster page for the new course. The student is redirected to
  #                    the Course List page.
  def destroy
    @course = @enrolled_course.course
    student_first_name = @enrolled_course.student.user.first_name
    student_last_name = @enrolled_course.student.user.last_name
    @enrolled_course.destroy
    respond_to do |format|
      if current_user.is_admin?
        format.html { redirect_to roster_path(@course), notice: 'You have sucessfully dropped ' + student_first_name + ' ' + student_last_name + ' from ' + @course.course_id + '!' }
        format.json { head :no_content }
      else
        format.html { redirect_to courses_path, notice: 'You have sucessfully dropped from ' + @course.course_id + '!' }
        format.json { head :no_content }
      end
    end
  end

  private
    #  Function: set_enrolled_course
    #    Parameters: None
    #    Pre-condition: The user must be logged in.
    #    Post-condition: The enrollment record is retrieved from the database.
    def set_enrolled_course
      @enrolled_course = EnrolledCourse.find(params[:id])
    end

    #  Function: enrolled_course_params
    #    Parameters: None
    #    Pre-condition: The user must be logged in.
    #    Post-condition: The params passed into the enrolled courses controller are accepted.
    def enrolled_course_params
      params.require(:enrolled_course).permit(:student_id, :course_id)
    end
end

# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: waitlists_controller.rb
# Description: Controller class for the waitlist entries
# Last modified on: 11/24/19

class WaitlistsController < ApplicationController
  before_action :set_waitlist, only: [:show, :edit, :update, :destroy]
  before_action :check_user_permissions, only: [:show, :index, :edit, :update, :destroy]
  
  #  Function: check_user_permissions
  #    Parameters: None
  #    Pre-condition: The user must be logged in.
  #    Post-condition: The user is directed to dashboard page if they're not an admin or professor.
  #                    Otherwise, no redirects are made.
  def check_user_permissions
    if user_signed_in?
      if !current_user.is_admin? && !current_user.is_professor?
          redirect_to home_dashboard_path, notice: "You don't have permission to access this page!"
      end
    end
  end

  #  Function: index
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be an admin.
  #    Post-condition: The user is redirected to the Waitlist Entries page.
  def index
  end

  #  Function: new
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be a student.
  #    Post-condition: The user is redirected to a form to fill out for the new waitlist entry.
  def new
    @waitlist = Waitlist.new
  end

  #  Function: create
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be a student. Also, the form for the new
  #                   waitlst entry is filled out and passes all validations
  #    Post-condition: The waitlist entry is created and saved into the database.
  #                    Then the student is redirected to the dashboard.
  def create
    @waitlist = Waitlist.new(waitlist_params)
    @course = Course.find(waitlist_params[:course_id])
    
    if !current_user.is_admin? && !current_user.is_professor?
        @waitlist.student_id = current_user.student.id 
    end

    respond_to do |format|
      if @waitlist.save
        format.html { redirect_to home_dashboard_path, notice: 'You have been successfully added to the waitlist for ' + @course.course_id + '!' }
        format.json { render :show, status: :created, location: @waitlist }
      else
        format.html { render :new }
        format.json { render json: @waitlist.errors, status: :unprocessable_entity }
      end
    end
  end

  #  Function: destroy
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be an admin or professor.
  #    Post-condition: The waitlist entry is deleted from the database. Then the admin/professor is redirected
  #                    to the Waitlist Entries.
  def destroy
    @waitlist.destroy
    respond_to do |format|
      format.html { redirect_to waitlists_path, notice: 'Waitlist record was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    #  Function: set_waitlist
    #    Parameters: None
    #    Pre-condition: The user must be logged in.
    #    Post-condition: The waitlist entry is retrieved from the database.
    def set_waitlist
      @waitlist = Waitlist.find(params[:id])
    end

    #  Function: waitlist_params
    #    Parameters: None
    #    Pre-condition: The user must be logged in.
    #    Post-condition: The params passed into the waitlists controller are accepted.
    def waitlist_params
      params.require(:waitlist).permit(:course_id, :student_id)
    end
end

# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: users_controller.rb
# Description: Controller class for the users
# Last modified on: 11/24/19

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
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
  #    Pre-condition: The user must be logged in and be either an admin or professor.
  #    Post-condition: The user is redirected to the User Accounts page.
  def index
    @users = User.all
  end

  #  Function: show
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be either an admin or professor.
  #    Post-condition: The user is redirected to the User Information page.
  def show
  end

  #  Function: new
  #    Parameters: None
  #    Pre-condition: The user must be logged out and must click Sign Up.
  #    Post-condition: The user is redirected to a form to fill out for the new user account.
  def new
    @user = User.new
  end

  #  Function: edit
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be either an admin or professor.
  #    Post-condition: The user is redirected to a form to fill out any changes for the user account.
  def edit
  end

  #  Function: create
  #    Parameters: None
  #    Pre-condition: The user must complete the sign up form. Also, the form for the new
  #                   course is filled out and passes all validations
  #    Post-condition: The user account is created and saved into the database.
  #                    Then the user is redirected to the dashboard.
  def create
    @user = User.new(user_params)
    log_in @user
    
    respond_to do |format|
      if @user.save
        redirect_to home_dashboard_path
        #format.html { redirect_to @user, notice: 'User was successfully created.' }
        #format.json { render :show, status: :created, location: @user }
        #if !@user.is_admin && !@user.is_professor && @user.student.nil?
        #  redirect_to new_student_path
        #else
        #  redirect_to home_dashboard_path
        #end
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #  Function: update
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be either an admin or professor. Also, the form 
  #                   for the user account is filled out and passes all validations.
  #    Post-condition: The changes to the course are made and saved into the database.
  #                    Then the admin/professor is redirected to the User Profile page.
  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #  Function: destroy
  #    Parameters: None
  #    Pre-condition: The user must be logged in and be an admin.
  #    Post-condition: The user account is deleted from the database. Then the admin is redirected
  #                    to the User Accounts page.
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User account was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    #  Function: set_user
    #    Parameters: None
    #    Pre-condition: The user must be logged in.
    #    Post-condition: The user account is retrieved from the database.
    def set_user
      @user = User.find(params[:id])
    end

    #  Function: user_params
    #    Parameters: None
    #    Pre-condition: The user must be logged in.
    #    Post-condition: The params passed into the users controller are accepted.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :is_admin, :is_professor, :student_id)
    end
end

# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: reigstrations_controller.rb
# Description: Controller class for user signups
# Last modified on: 11/24/19

# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  #def new
  #  super
  #end

  # POST /resource
  #def create
  #  super
  #end

  # GET /resource/edit
  #def edit
  #  super
  #end

  # PUT /resource
  #def update
  #  super
  #end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  #def cancel
  #  super
  #end

  protected

  #  Function: configure_sign_up_params
  #    Parameters: first_name, last_name
  #    Pre-condition: The user must create an account via sign up form.
  #    Post-condition: The user's input information is configured.
  def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  #  Function: configure_account_update_params
  #    Parameters: first_name, last_name, email, password
  #    Pre-condition: The user must update an account via form.
  #    Post-condition: The user's input information is configured.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password])
  end

  # The path used after sign up.
  #def after_sign_up_path_for(resource)
    #render partial: 'students/form', object: @student
    #redirect_to 'home/dashboard'
    #new_student_path
    #super(resource)
  #end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

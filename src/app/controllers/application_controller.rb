# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: application_controller.rb
# Description: Controller superclass for the Rails application
# Last modified on: 11/24/19

class ApplicationController < ActionController::Base
    layout "application"
    before_action :authenticate_user!
    before_action :check_student_registration, unless: :devise_controller?


    private
    #  Function: check_student_registration
    #    Parameters: None
    #    Pre-condition: The user must be logged in, not be an admin or professor, and not have a student account
    #    Post-condition: The user is directed to the new student account form
    def check_student_registration
        if user_signed_in?
            if current_user.student.nil? && !current_user.is_admin? && !current_user.is_professor?
                redirect_to new_student_path
            end
        end
    end
end

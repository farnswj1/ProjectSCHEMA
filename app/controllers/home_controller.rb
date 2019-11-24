# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: home_controller.rb
# Description: Controller class for the home, dashboard, and faqs pages.
# Last modified on: 11/24/19

class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:home, :login]
  
  #  Function: home
  #    Parameters: None
  #    Pre-condition: None
  #    Post-condition: The home page is retrieved.
  def home
  end

  #  Function: dashboard
  #    Parameters: None
  #    Pre-condition: The user must be logged in.
  #    Post-condition: The dashboard page is retrieved.
  def dashboard
  end

  #  Function: dashboard
  #    Parameters: None
  #    Pre-condition: The user must be logged in.
  #    Post-condition: The FAQs page is retrieved.
  def faqs
  end
end

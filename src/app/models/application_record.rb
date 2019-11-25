# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: application_record.rb
# Description: Model superclass for the Rails application
# Last modified on: 11/24/19

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

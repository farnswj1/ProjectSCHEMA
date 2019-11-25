class SetDefaultValueForSeatsTakenInCourses < ActiveRecord::Migration[5.2]
  def change
    change_column_default :courses, :seats_taken, 0
  end
end

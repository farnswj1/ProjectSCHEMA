class RemoveSeatsTakenColumnFromCourses < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :seats_taken
  end
end

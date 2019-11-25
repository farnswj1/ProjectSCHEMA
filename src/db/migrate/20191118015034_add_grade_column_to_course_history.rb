class AddGradeColumnToCourseHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :course_histories, :grade, :string
  end
end

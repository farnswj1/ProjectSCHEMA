class CreateEnrolledCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :enrolled_courses do |t|
      t.references :student, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end

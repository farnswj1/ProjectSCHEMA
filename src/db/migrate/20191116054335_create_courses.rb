class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    drop_table :courses

    create_table :courses do |t|
      t.string :course_id
      t.string :course_title
      t.string :description
      t.references :professor, foreign_key: true
      t.integer :minimum_seats
      t.integer :maximum_seats
      t.integer :seats_taken

      t.timestamps
    end
  end
end

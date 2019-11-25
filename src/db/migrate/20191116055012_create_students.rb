class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    drop_table :students

    create_table :students do |t|
      t.string :student_id
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :major
      t.float :gpa
      t.string :email

      t.timestamps
    end
  end
end

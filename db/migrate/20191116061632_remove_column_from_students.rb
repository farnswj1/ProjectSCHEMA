class RemoveColumnFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :student_id
  end
end

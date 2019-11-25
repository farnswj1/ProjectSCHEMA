class ChangeReferenceColumnInCoursesTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :professor_id
    add_reference :courses, :user, index: true, null: false
  end
end

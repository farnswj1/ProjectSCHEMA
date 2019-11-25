class AddUserReferenceToStudentsTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :students, :user, index: true, null: false
  end
end

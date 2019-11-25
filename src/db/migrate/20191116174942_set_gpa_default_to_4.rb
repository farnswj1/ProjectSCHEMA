class SetGpaDefaultTo4 < ActiveRecord::Migration[5.2]
  def change
    change_column_default :students, :gpa, 4.0
  end
end

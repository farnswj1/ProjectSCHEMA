class DropTableProfessors < ActiveRecord::Migration[5.2]
  def change
    drop_table :professors
  end
end

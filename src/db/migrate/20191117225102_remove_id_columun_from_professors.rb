class RemoveIdColumunFromProfessors < ActiveRecord::Migration[5.2]
  def change
    remove_column :professors, :professor_id
  end
end

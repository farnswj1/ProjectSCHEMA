class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.boolean :is_admin, null: false, default: false
      t.boolean :is_professor, null: false, default: false
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end

class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
			t.references :department, index: true, foreign_key: true
			t.string :professor_name

      t.timestamps null: false
    end
  end
end

class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
			t.references :building, index: true, foreign_key: true
			t.string :classroom_name

      t.timestamps null: false
    end
  end
end

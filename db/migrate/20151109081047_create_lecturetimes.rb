class CreateLecturetimes < ActiveRecord::Migration
  def change
    create_table :lecturetimes do |t|
			t.references :lecture, index: true, foreign_key: true
			t.references :classroom, index: true, foreign_key: true
			t.integer :day
			t.integer :starttime
			t.integer :endtime

      t.timestamps null: false
    end
  end
end

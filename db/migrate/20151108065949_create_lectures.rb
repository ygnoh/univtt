class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
			t.references :department, index: true, foreign_key: true
			t.references :professor, index: true, foreign_key: true
			t.references :classification, index: true, foreign_key: true
			t.integer :year
			t.integer :semester
			t.string :lecture_name
			t.integer :level
			t.integer :lecture_number
			t.string :lecture_division
			t.integer :grade
			t.boolean :relative, default: true
			t.boolean :passfail, default: false
			t.boolean :english, default: false
			t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end

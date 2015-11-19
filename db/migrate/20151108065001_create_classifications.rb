class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
			t.references :school, index: true, foreign_key: true
			t.string :classification_name

      t.timestamps null: false
    end
  end
end

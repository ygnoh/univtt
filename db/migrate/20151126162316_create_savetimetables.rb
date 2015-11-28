class CreateSavetimetables < ActiveRecord::Migration
  def change
    create_table :savetimetables do |t|
			t.references :user, index: true, foreign_key: true
			t.string :lectures, array: true, default: []

      t.timestamps null: false
    end
  end
end

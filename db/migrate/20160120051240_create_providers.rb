class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
			t.references :school, index: true, foreign_key: true
			t.string :name
			t.string :group
			t.integer :year
			t.integer :semester
			t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end

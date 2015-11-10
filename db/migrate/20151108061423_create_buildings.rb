class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
			t.references :school, index: true, foreign_key: true
			t.string :building_name

      t.timestamps null: false
    end
  end
end

class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
			t.string :school_name

      t.timestamps null: false
    end
  end
end

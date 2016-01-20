class AddActiveToClassifications < ActiveRecord::Migration
  def change
    add_column :classifications, :active, :boolean, default: true
    add_column :classrooms, :active, :boolean, default: true
    add_column :lecturetimes, :active, :boolean, default: true
    add_column :professors, :active, :boolean, default: true
  end
end

class AddActiveToSchools < ActiveRecord::Migration
  def change
		add_column :schools, :active, :boolean, :default => true
  end
end

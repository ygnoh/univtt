class AddActiveToDepartments < ActiveRecord::Migration
  def change
		add_column :departments, :active, :boolean, :default => true
  end
end

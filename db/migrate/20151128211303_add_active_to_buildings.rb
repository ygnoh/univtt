class AddActiveToBuildings < ActiveRecord::Migration
  def change
		add_column :buildings, :active, :boolean, :default => true
  end
end

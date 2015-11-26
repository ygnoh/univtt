class AddActiveToSavetimetables < ActiveRecord::Migration
  def change
    add_column :savetimetables, :active, :boolean, :default => true
  end
end

class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :content
      t.integer :view_count, default: 0
      t.boolean :active, default: true
      
      t.timestamps null: false
    end
  end
end

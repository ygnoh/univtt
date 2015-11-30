class CreatePcomments < ActiveRecord::Migration
  def change
    create_table :pcomments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.string  :content
      t.timestamps null: false
    end
  end
end
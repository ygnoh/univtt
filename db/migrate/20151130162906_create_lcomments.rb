class CreateLcomments < ActiveRecord::Migration
  def change
    create_table :lcomments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :lecture, index: true, foreign_key: true
      t.string  :content
      t.timestamps null: false
    end
  end
end

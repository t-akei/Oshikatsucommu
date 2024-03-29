class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :genre_id
      t.string :title, null: false
      t.text :body, null: false
      t.string :category
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end

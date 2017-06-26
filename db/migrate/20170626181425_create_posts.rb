class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :title, null: false
      t.text :url
      t.text :content
      t.integer :sub_id, null: false
      t.integer :author_id, null: false
      t.timestamps
    end
  end
end

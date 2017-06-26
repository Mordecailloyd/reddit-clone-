class CreateSubs < ActiveRecord::Migration[5.0]
  def change
    create_table :subs do |t|
      t.text :title, null: false
      t.text :description, null: false
      t.integer :moderator_id, null: false
      t.timestamps
    end
  end
end

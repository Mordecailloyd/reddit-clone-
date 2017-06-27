class Modifypostsubs < ActiveRecord::Migration[5.0]
  def change
    add_index :post_subs, :post_id
    add_index :post_subs, :sub_id
    add_index :post_subs, [:post_id, :sub_id], unique: true
  end
end

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :post_title
      t.string :post_description
      t.string :post_category
      t.string :post_type
      t.integer :user_id
      t.integer :post_likes, default: 0

      t.timestamps
    end
  end
end

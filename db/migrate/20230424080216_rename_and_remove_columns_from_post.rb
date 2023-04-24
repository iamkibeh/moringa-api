class RenameAndRemoveColumnsFromPost < ActiveRecord::Migration[7.0]
  def change
    change_table :posts do |t|
      t.rename :post_img, :post_images
      t.remove :post_comment, :post_like
    end
  end
end

class AddPostToComment < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :post, foreign_key: true, :null => false
  end
end

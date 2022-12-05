class CreateUserPostLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_post_likes do |t|
      t.boolean :liked
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end

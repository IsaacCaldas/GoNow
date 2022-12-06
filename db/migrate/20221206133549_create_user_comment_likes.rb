class CreateUserCommentLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_comment_likes do |t|
      t.boolean :liked
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end

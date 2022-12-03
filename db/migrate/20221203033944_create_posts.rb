class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :description
      t.integer :likes, :default => 0
      t.string :img_url
      t.references :theme, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

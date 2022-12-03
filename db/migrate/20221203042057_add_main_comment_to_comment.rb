class AddMainCommentToComment < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :main_comment
  end
end

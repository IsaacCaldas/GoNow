class Comment < ApplicationRecord
  # self references
  has_many :related_comments, foreign_key: "main_comment_id", class_name: "Comment"
  belongs_to :main_comment, class_name: "Comment", optional: true  
end

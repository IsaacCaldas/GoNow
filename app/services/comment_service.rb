class CommentService
  attr_accessor :description, :main_comment_id, :post_id

  def initialize(description, main_comment_id, post_id)
    @description = description
    @main_comment_id = main_comment_id
    @post_id = post_id
  end

  def errors
    errors ||= []

    [
      { condition: @description.blank?, message: "Description can't be blank." },
      { condition: @post_id.blank?, message: "Post references can't be blank." },
      { condition: post_unexistent, message: "Post references can't be blank." },
      { condition: main_comment_unexistent, message: 'Unexistent main comment' }
    ].each do |error|
      errors << error[:message] if error[:condition]
    end

    errors
  end

  def post_unexistent
    post ||= true
    post = Post.find(@post_id)
    !post
  end

  def main_comment_unexistent
    comment ||= true
    comment = Comment.find(@main_comment_id) if @main_comment_id
    !comment
  end

  def handle_create_or_update_comment(comment, params)
    # TODO: make a validation of params
    if comment
      comment.update(params)
    else
      params[:user_id] = current_user.id
      Comment.create(params)
    end
  end

  def handle_destroy_comment(comment)
    user = 'owner'
    user = 'admin' if current_user.admin && comment.user_id != current_user.id
    comment.update(description: "The comment has been removed by the #{user}.")
  end

  def handle_like(comment_id, comment)
    user_comment_like = UserCommentLike.where(user_id: current_user.id, comment_id: comment_id).first
    comment_likes = comment.likes

    if user_comment_like.present?
      user_comment_like.liked ? comment_likes -= 1 : comment_likes += 1
      user_comment_like.update(liked: !user_comment_like.liked)
    else
      UserCommentLike.create(user_id: current_user.id, comment_id: comment_id, liked: true)
      comment_likes += 1
    end

    comment.update(likes: comment_likes)
  end
end

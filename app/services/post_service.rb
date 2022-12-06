class PostService 
  attr_accessor :title, :theme_id, :user_id

  def initialize(title, theme_id, user_id)
    @title = title
    @theme_id = theme_id
    @user_id = user_id
  end

  def errors
    errors ||= []
    
    [
      {condition: @title.blank?, message: "Title can't be blank."},
      {condition: @theme_id.blank?, message: "Theme references can't be blank."},
      {condition: theme_unexistent, message: "Unexistent theme."},
      {condition: @user_id.blank?, message: "User references can't be blank."},
      {condition: user_unexistent, message: "Unexistent user."}
    ].each do |error|
      errors << error[:message] if error[:condition]
    end

    errors
  end

  def theme_unexistent
    theme = true
    theme = Theme.find(@theme_id)
    !theme
  end

  def user_unexistent
    user = true
    user = User.find(@user_id)
    !user  end

  def handle_create_or_update_post(post, params)
    # TODO: make a validation of params
    if post 
      post.update(params)
    else
      Post.new(params)
    end
  end

  def handle_like(post_id, post)
    user_post_like = UserPostLike.where(user_id: current_user.id, post_id: post_id).first
    post_likes = post.likes

    if user_post_like.present?
      user_post_like.update(liked: !user_post_like.liked)
      user_post_like.liked ? post_likes -= 1 : post_likes += 1
    else  
      UserPostLike.new(user_id: current_user.id, post_id: post_id, liked: true)
      post_likes += 1
    end

    post.update(likes: post_likes)
  end
end 
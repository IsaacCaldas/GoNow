class PostService 
  attr_accessor :title :description, :image_url, :theme_id

  def initialize(title, description, image_url, theme_id)
    @title = title
    @description = description
    @image_url = image_url
    @theme_id = theme_id
  end

  def errors
    errors ||= []
    
    [
      {condition: @title.blank?, message: "Title can't be blank."},
      {condition: @theme_id.blank?, message: "Theme references can't be blank."},
      {condition: theme_unexistent, message: "Unexistent theme."},
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

  def handle_create_or_update_post(post, params)
    # TODO: make a validation of params
    if post 
      post.update(params)
    else
      Post.create(
        title: @title,
        description: @description,
        image_url: @image_url,
        theme_id: @theme_id,
        user_id: current_user.id
      )
    end
  end

  def handle_like(post_id, post)
    user_post_like = UserPostLike.where(user_id: current_user.id, post_id: post_id).first
    post_likes = post.likes

    if user_post_like.present?
      user_post_like.liked ? post_likes -= 1 : post_likes += 1
      user_post_like.update(liked: !user_post_like.liked)
    else  
      UserPostLike.create(user_id: current_user.id, post_id: post_id, liked: true)
      post_likes += 1
    end

    post.update(likes: post_likes)
  end
end 
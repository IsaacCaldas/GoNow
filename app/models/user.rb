class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :user_post_likes
  has_many :comments
  has_many :user_comment_likes
  has_many :user_chats
  has_many :messages

  def fullname
    "#{name} #{surname}"
  end

  def self.handle_update_username(current_user)
    current_user.update(username: current_user.username.insert(0, '@'))
  end
end
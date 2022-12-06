class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts 
  has_many :user_post_likes
  has_many :comments
  has_many :user_comment_likes
  
  def fullname
    "#{self.name} #{self.surname}"
  end
end

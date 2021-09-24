class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :posts
  has_one_attached :image
  has_many :friend_requests, foreign_key: :sender_id
  
  def not_a_friend(user_id)
    FriendRequest.joins(:user).where(user: {'id = ?' self.id or user_id}).where('receiver_id = ?' user_id or self.id, 'accepted = ?' true).blank?
  end

  def unaccepted_request(user_id)
    FriendRequest.joins(:user).where(user: {'id = ?' self.id or user_id}).where('receiver_id = ?' user_id or self.id, 'accepted = ?' nil).blank?
  end
end

class FriendRequest < ApplicationRecord  
  validates :sender_id, presence: true
  validates :sender_id, uniqueness: {scope: :receiver_id}
  validates :receiver_id, presence: true
  belongs_to :user, foreign_key: :sender_id
  
  validate :custom_validator
  
  def custom_validator
    :sender_id != :receiver_id
  end
end

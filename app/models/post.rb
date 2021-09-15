class Post < ApplicationRecord
  belongs_to :user
  validates_presence_of :title, :content
  validates :title, uniqueness: {scope: :user_id}
  validates :content, uniqueness: {scope: :user_id}
  has_one_attached :image, :dependent => :destroy
end

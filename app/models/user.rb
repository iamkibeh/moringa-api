class User < ApplicationRecord
  has_secure_password

  # attach avatar to user
  has_one_attached :avatar
  has_one_attached :cover_photo

  validates :email, presence: true, uniqueness: true
  # validates :password, presence: true
  validates :user_type, presence: true, inclusion: { in: %w[alumni client] }
  validates :first_name, presence: true
  validates :last_name, presence: true

  # user associations
  has_many :comments
  has_many :likes
  has_many :posts
  has_many :commented_posts, through: :comments, source: :post
  has_many :liked_posts, through: :likes, source: :post
end

class User < ApplicationRecord
  has_secure_password

  # attach avatar to user
  has_one_attached :avatar
  has_one_attached :cover_photo

  validates :email, presence: true, uniqueness: true
  validates :user_type, presence: true, inclusion: { in: %w[alumni client] }
  validates :first_name, presence: true
  validates :last_name, presence: true

  # user associations
  has_many :comments
  has_many :likes
  has_many :posts, dependent: :destroy
  has_many :commented_posts, through: :comments, source: :post
  has_many :liked_posts, through: :likes, source: :post

  def profile_img
    Rails.application.routes.url_helpers.url_for(avatar) if avatar.attached?
  end

  def cover_img
    if cover_photo.attached?
      Rails.application.routes.url_helpers.url_for(cover_photo)
    end
  end

  before_save :downcase_email
  before_save :capitalize_names

  def downcase_email
    self.email = email.downcase
  end

  def capitalize_names
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end


end

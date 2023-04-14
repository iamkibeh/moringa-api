class Post < ApplicationRecord
  # associations with other models
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # validations for post model
  validates :user_id, presence: true
  validate :at_least_one_attribute_present

  def at_least_one_attribute_present
    # if [title, content].all?(&:blank?)
    unless post_description.present? || post_img.present? || post_title.present?
      errors.add(:base, "Post must have a description, title or image.")
    end
  end
end

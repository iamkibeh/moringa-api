class Post < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many_attached :images
  validate :at_least_one_attribute_present

  def at_least_one_attribute_present
    # if [title, content].all?(&:blank?)
    unless post_description.present? || post_img.present? || post_title.present?
      errors.add(:base, "Post must have a description, title or image.")
    end
  end

  def get_post_images
    # images.map { |image| Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) }
    if self.images.attached?
      self.images.map { |image| url_for(image) }
    else
      []
    end
  end
end

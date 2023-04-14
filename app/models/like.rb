class Like < ApplicationRecord
  # A user can only like one post once.

  belongs_to :user
  belongs_to :post

  # validates :user_id, uniqueness: { scope: :post_id }
  validates :user_id,
            uniqueness: {
              scope: :post_id,
              message: "can only like a post once."
            }
end

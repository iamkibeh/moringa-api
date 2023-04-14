class Comment < ApplicationRecord
  # associations with other models
  belongs_to :user
  belongs_to :post
  #   a comment can have many comments as children ie replies (parent_comment_id)
  belongs_to :parent_comment, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: "parent_comment_id"
end

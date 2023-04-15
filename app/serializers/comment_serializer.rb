class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :post_id, :user_id, :created_at, :parent_comment_id
  #  :user,
  #  :post
  has_many :replies, serializer: CommentSerializer
end

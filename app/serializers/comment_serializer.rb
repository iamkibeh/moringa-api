class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :post_id, :user_id, :created_at, :parent_comment_id
  belongs_to :user
  #  :user,
  #  :post
  has_many :replies, serializer: CommentSerializer

  def user
    object.user.as_json(only: %i[id first_name last_name profile_img])
  end
end

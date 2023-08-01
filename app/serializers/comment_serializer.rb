class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :post_id, :user_id, :created_at, :parent_comment_id
  belongs_to :user
  has_many :replies, Serializer: CommentSerializer

  def user
    object.user.as_json(only: %i[id first_name last_name ]).merge({profile_img: object.user.get_profile_img})
  end


  def replies
    object.replies.map do |reply|
        {
          id: reply.id,
          comment: reply.comment,
          post_id: reply.post_id,
          user_id: reply.user_id,
          created_at: reply.created_at,
          parent_comment_id: reply.parent_comment_id,
          user: reply.user.as_json(only: %i[id first_name last_name]).merge({profile_img: reply.user.get_profile_img}),
        }
    end
  end

end

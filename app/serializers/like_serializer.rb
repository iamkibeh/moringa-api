class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :post_id, :created_at
  belongs_to :user

  # include the user object

  def user
    object.user.as_json(only: %i[id first_name last_name profile_img])
  end
end

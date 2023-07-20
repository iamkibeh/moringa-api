class PostSerializer < ActiveModel::Serializer
  attributes :id,
             :post_title,
             :post_description,
             :post_likes,
             :media,
             :post_category,
             :post_type,
             :user_id,
             :created_at

  belongs_to :user, serializer: PostUserSerializer
  has_many :comments

  # serialize the user object
  # def user
  #   data = object.user.as_json(only: %i[id first_name last_name])
  #   data["profile_img"] = rails_blob_url(object.user.avatar) if object.user.avatar.attached?
  #   data
  # end

  def media
    object.get_post_images
  end
end

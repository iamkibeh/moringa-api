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



  def media
    object.get_post_images
  end
end

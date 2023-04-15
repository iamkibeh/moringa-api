class PostSerializer < ActiveModel::Serializer
  attributes :id,
             :post_title,
             :post_description,
             :post_img,
             :post_like,
             :post_category,
             :post_comment,
             :post_type,
             :user_id,
             :created_at

  belongs_to :user
  has_many :comments

  # serialize the user object
  def user
    object.user.as_json(only: %i[id first_name last_name profile_img])
  end
end

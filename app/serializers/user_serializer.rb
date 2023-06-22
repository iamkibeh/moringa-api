class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :first_name,
             :last_name,
             :username,
             :phone_number,
             :github_url,
             :linkedin_url,
             :twitter_url,
             :cv_url,
             :portfolio_url,
             :profile_img,
             :cover_img,
             :country,
             :bio,
             :profession,
             :user_type,
             :company_name,
             :company_website,
             :user_location,
             :created_at,
             :updated_at


  has_many :posts

  def profile_img
    object.get_profile_img
  end

  def cover_img
    object.get_cover_img
  end
end

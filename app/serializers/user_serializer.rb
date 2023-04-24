class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :first_name,
             :last_name,
             #  :updated_at,
             :phone_number,
             :github_url,
             :linkedin_url,
             :twitter_url,
             :cv_url,
             :profile_img,
             :cover_img,
             :country,
             :bio,
             :profession,
             :user_type,
             :company_name,
             :company_website,
             :user_location,
             :created_at

  has_many :posts
end

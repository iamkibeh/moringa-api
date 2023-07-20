class PostUserSerializer < ActiveModel::Serializer
 attributes :id, :first_name, :last_name, :profile_img


 def profile_img
    object.get_profile_img
  end
end

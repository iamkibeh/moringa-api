class  Api::V1::PhotosController < ApplicationController
  # update the profile image of a user

  def update_profile_img
    @user = User.find(params[:id])
    if @user.update(user_params.except(:profile_img))
      @user.avatar.attach(params[:profile_img]) if params[:profile_img].present?
      #   include cover_img logic here
      if params[:cover_img].present?
        @user.cover_photo.attach(params[:cover_img])
      end

      user_json =
        @user.as_json(include: %i[profile_img cover_img]).merge(
          profile_img: url_for(@user.avatar),
          cover_img: url_for(@user.cover_photo)
        )
      return render json: user_json, status: :ok
    else
      return(
        render json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end
end

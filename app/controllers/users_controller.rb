class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[create index show]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # all users
  def index
    # debugger
    @users = User.all
    render json: @users, status: :ok
  end

  #   find single user
  def show
    @user = User.find_by!(id: params[:id])
    # debugger
    # user_json =
    #   @user.as_json(include: :avatar).merge(profile_img: url_for(@user.avatar))
    render json: @user, status: :ok
  end

  #    create new user
  # POST /users
  def create
    @user = User.new(signup_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  #   update user details
  def update
    @user = User.find(params[:id])
    if @user.update(user_params.except(:avatar, :cover_photo))
      if user_params[:avatar].present? || user_params[:cover_photo].present?
        if user_params[:avatar].present?
          @user.avatar.attach(user_params[:avatar])
        end
        if user_params[:cover_photo].present?
          @user.cover_photo.attach(user_params[:cover_photo])
        end
        if @user.update(
             profile_img: @user.avatar,
             cover_img: @user.cover_photo
           )
          return render json: @user, status: :ok
        end
      end
      return render json: @user, status: :ok
    else
      return(
        render json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  #   delete user

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    return render json: {}, status: :no_content
  end

  # custom route actions

  def activities
    @user = User.find(params[:id])
    @comments = @user.comments
    @posts = @user.posts
    @liked_posts = @user.liked_posts
    # if @comments.present? || @posts.present? || @liked_posts.present?
      render json: {
               comments: @comments,
               posts: @posts,
               liked_posts: @liked_posts
             },
             status: :ok
    # else
      # render json: { error: "No activities found" }, status: :ok
    # end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :phone_number,
      :user_location,
      :email,
      :password,
      :password_confirmation,
      :agreement,
      :country,
      :user_type,
      :github_url,
      :twitter_url,
      :linkedin_url,
      :cv_url,
      :bio,
      :company_name,
      :company_website,
      # :profile_img,
      # :cover_img
      :avatar,
      :cover_photo
    )
  end

  def signup_params
    params.permit(:email, :password, :password_confirmation, :agreement, :user_type, :first_name, :last_name)
  end

  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end
end

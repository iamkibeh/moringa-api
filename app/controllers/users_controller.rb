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
    @user = User.create(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  #   update user details
  def update
    @user = User.find(params[:id])
    if @user.update(user_params.except(:profile_img, :cover_img))
      if params[:profile_img].present? || params[:cover_img].present?
        if params[:profile_img].present?
          @user.avatar.attach(params[:profile_img])
        end
        if params[:cover_img].present?
          @user.cover_photo.attach(params[:cover_img])
        end
        if @user.update(
             profile_img: url_for(@user.avatar),
             cover_img: url_for(@user.cover_photo)
           )
          return render json: @user, status: :ok
        end
      end
      # debugger

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
    if @comments.present? || @posts.present? || @liked_posts.present?
      render json: {
               comments: @comments,
               posts: @posts,
               liked_posts: @liked_posts
             },
             status: :ok
    else
      render json: { error: "No activities found" }, status: :not_found
    end
  end

  private

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :phone_number,
      :user_location,
      :email,
      :password,
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
      :profile_img,
      :cover_img
    )
  end

  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end
end

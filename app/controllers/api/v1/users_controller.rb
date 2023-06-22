class  Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: %i[create]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
  # all users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  #   find single user
  def show
    render json: current_user, status: :ok
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
    current_user.update!(user_params)
    render json: current_user, status: :ok
  end

  #   delete user

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    return render json: {}, status: :no_content
  end

  # custom route actions

  def activities
    @comments = current_user.comments
    @posts = current_user.posts
    @liked_posts = current_user.liked_posts
    render json: { comments: @comments, posts: @posts, liked_posts: @liked_posts }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
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
      :portfolio_url,
      :cv_url,
      :bio,
      :company_name,
      :company_website,
      :avatar,
      :cover_photo,
      profession: [],
    )
  end

  def signup_params
    params.permit(:email, :password, :password_confirmation, :agreement, :user_type, :first_name, :last_name)
  end

  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end

  def render_invalid_response(error)
    render json: { errors: error.record.errors.full_messages }, status: :unprocessable_entity
  end
end

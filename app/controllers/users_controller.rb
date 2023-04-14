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
    if @user.update(user_params)
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

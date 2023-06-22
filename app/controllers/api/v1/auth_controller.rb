class  Api::V1::AuthController < ApplicationController
  # skip the jwt authentication for the autologin and create actions

  skip_before_action :authorized, only: %i[create autologin]

  # creating session of a user with jwt
  def create
    @user = User.find_by(email: user_login_params[:email])
    @user_type = User.find_by(user_type: user_login_params[:user_type])

    if @user && @user_type && @user.authenticate(user_login_params[:password])
      if @user.user_type == user_login_params[:user_type]
        token = encode_token({ user_id: @user.id })
        render json: {
                 #  user: UserSerializer.new(@user),
                 user: @user,
                 jwt: token,
                 message: "Your are Successfully logged in"
               },
               status: :accepted
      else
        render json: {
                 error:
                   "We could not find an account with that email address. Please register an account or check your email and try again."
               },
               status: :unprocessable_entity
      end
    else
      render json: {
               message: "Invalid email or password"
             },
             status: :unauthorized
    end
  end

  # Created this method to allow logging in automatically
  def autologin
    if current_user
      render json: current_user
    else
      render json: { errors: "No user could be found" }
    end
  end

  private

  def user_login_params
    params.permit(:email, :password, :user_type)
  end
end

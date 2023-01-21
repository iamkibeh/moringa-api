class UsersController < ApplicationController

    # POST /users
    def create
        @user = User.create(user_params)
        if @user.valid?
            token = encode_token({user_id: @user.id})
            render json: {user: @user, token:token, message: "Account succesfully created, please log in."}, status: :ok
        else
            render json: {error: "Invalid username or password"}, status: :unprocessable_entity
        end
    end
    

    # Post/login
    def login
        @user = User.find_by(email: user_params[:email])
        @user_type = User.find_by(user_type: user_params[:user_type])

        if @user && @user_type && @user.authenticate(user_params[:password])
            token = encode_token({user_id: @user.id})
            render json: {user: @user, token: token, message: "Your are Successfully logged in" }, status: :ok
        else
            render json: {error: 'Invalid email or password'}, status: :unprocessable_entity
        end
    end
    private
    
    def user_params
        params.require(:user).permit(:first_name, :last_name, :phone_number,:user_location,:email, :password, :agreement, :country, :user_type,  :github_url, :twitter_url, :linkedin_url, :cv_url, :bio, :company_name, :company_website, :profile_img, :cover_img )
    end
end

class UsersController < ApplicationController

    # POST /users
    def create
        @user = User.create(user_params)
        if @user.valid?
            token = encode_token({user_id: @user.id})
            render json: {user: @user, token:token}, status: :ok
        else
            render json: {error: "Invalid username or password"}, status: :unprocessable_entity
        end
    end
    
    private
    
    def user_params
        params.require(:user).permit(:first_name, :last_name, :phone_number,:user_location,:email, :password, :agreement, :country, :user_type,  :github_url, :twitter_url, :linkedin_url, :cv_url, :bio, :company_name, :company_website, :profile_img, :cover_img )
    end
end

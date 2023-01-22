class UsersController < ApplicationController

    # POST /users
    def create
        @user = User.create(user_params)
        byebug
        if @user.valid?
            # token = encode_token({user_id: @user.id})
            render json: {user: @user, message: "Account succesfully created, please log in."}, status: :ok
        else
            render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end
    

    # Post/login for alumni login
    def alumni_login
        @user = User.find_by(email: user_params[:email])
        @user_type = User.find_by(user_type: user_params[:user_type])

        if @user && @user_type && @user.authenticate(user_params[:password])
            if @user.user_type == user_params[:user_type]

                token = encode_token({user_id: @user.id})
                render json: {user: @user, token: token, message: "Your are Successfully logged in" }, status: :ok
            else
                render json: {error: 'We could not find an account with that email address. Please register an account or check your email and try again.'}, status: :unprocessable_entity
            end
        
        else
            render json: {error: 'The email or password you entered is incorrect. Please check your login credentials and try again.'}, status: :unprocessable_entity
        end
    end
    # Post/login for company login
    def company_login
        @user = User.find_by(email: user_params[:email])
        @user_type = User.find_by(user_type: user_params[:user_type])

        if @user && @user_type && @user.authenticate(user_params[:password])
            if  @user.user_type == user_params[:user_type]
                token = encode_token({user_id: @user.id})
                render json: {user: @user, token: token, message: "Your are Successfully logged in" }, status: :ok
            else
                render json: {error: 'We could not find an account with that email address. Please register an account or check your email and try again.'}, status: :unprocessable_entity
            end
        
        else
            render json: {error: 'The email or password you entered is incorrect. Please check your login credentials and try again.'}, status: :unprocessable_entity
        end
    end
    private
    
    def user_params
        params.require(:user).permit(:first_name, :last_name, :phone_number,:user_location,:email, :password, :agreement, :country, :user_type,  :github_url, :twitter_url, :linkedin_url, :cv_url, :bio, :company_name, :company_website, :profile_img, :cover_img )
    end
end

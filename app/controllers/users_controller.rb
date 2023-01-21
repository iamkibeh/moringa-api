class UsersController < ApplicationController



    private
    def user_params
        params.permit(:first_name, :last_name, :phone_number,:user_location,:email, :password, :agreement, :country, :user_type, :user_location, :github_url, :twitter_url, :linkedin_url, :cv_url, :bio, :company_name, :company_website, :profile_img, :cover_img )
    end
end

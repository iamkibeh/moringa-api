Rails.application.routes.draw do

    namespace :api do
        namespace :v1 do
            mount ActionCable.server => '/cable'

            post "/login", to: "auth#create"
            post "/signup", to: "users#create"
            resources :users, only: %i[update index show create] do
                # get "followers", to: "users#followers"
                # get "following", to: "users#following"
                get "activities" => "users#activities"
                patch "profile_img" => "users#update_profile_img"
            end
            # post related routes
            resources :posts do
                resources :comments, only: %i[index create update destroy]
                resources :likes, only: %i[index create destroy]
            end
            delete "/posts/:post_id/likes", to: "likes#destroy"
            get "/posts/:post_id/comments/:id", to: "comments#show"

            # update user cover photo and profile photo
        end
    end
end



#   # update user cover photo and profile photo

#   patch "/users/:id/profile_img", to: "users#update_profile_img"


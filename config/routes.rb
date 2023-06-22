Rails.application.routes.draw do
    namespace :api do
        namespace :v1 do
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
            # update user cover photo and profile photo
        end
    end
end



#   # resources :likes
#   # resources :comments
#   resources :posts
#   # resource :users, only: %i[update destroy]
#   post "/login", to: "auth#create"
#   post "/signup", to: "users#create"
#   get "/users", to: "users#index"
#   get "/users/:id", to: "users#show"
#   patch "/users/:id", to: "users#update"
#   get "users/:id/activities", to: "users#activities"

#   # post related routes
#   # get "/posts", to: "posts#index"

#   # likes related routes
#   get "/posts/:id/likes", to: "likes#index"
#   post "/posts/:id/likes", to: "likes#create"
#   delete "/posts/:id/likes", to: "likes#destroy"

#   # comments related routes
#   get "/posts/:id/comments", to: "comments#index"
#   post "/posts/:id/comments", to: "comments#create"
#   patch "/posts/:id/comments", to: "comments#update"
#   delete "/posts/:id/comments", to: "comments#destroy"
#   post "/posts/:id/comments/:comment_id", to: "comments#create"
#   get "/posts/:id/comments/:comment_id", to: "comments#show"

#   # update user cover photo and profile photo

#   patch "/users/:id/profile_img", to: "users#update_profile_img"
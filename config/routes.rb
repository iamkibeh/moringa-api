Rails.application.routes.draw do
  # resources :likes
  # resources :comments
  resources :posts
  # resource :users, only: %i[update destroy]
  post "/login", to: "auth#create"
  post "/signup", to: "users#create"
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  patch "/users/:id", to: "users#update"
  get "users/:id/activities", to: "users#activities"

  # post related routes
  # get "/posts", to: "posts#index"

  # likes related routes
  get "/posts/:id/likes", to: "likes#index"
  post "/posts/:id/likes", to: "likes#create"
  delete "/posts/:id/likes", to: "likes#destroy"

  # comments related routes
  get "/posts/:id/comments", to: "comments#index"
  post "/posts/:id/comments", to: "comments#create"
  patch "/posts/:id/comments", to: "comments#update"
  delete "/posts/:id/comments", to: "comments#destroy"
  post "/posts/:id/comments/:comment_id", to: "comments#create"
  get "/posts/:id/comments/:comment_id", to: "comments#show"

  # update user cover photo and profile photo

  patch "/users/:id/profile_img", to: "users#update_profile_img"
end

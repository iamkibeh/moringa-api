Rails.application.routes.draw do
  resources :likes
  resources :comments
  resources :posts
  # resource :users, only: %i[update destroy]
  post "/login", to: "auth#create"
  post "/signup", to: "users#create"
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  patch "/users/:id", to: "users#update"
end

Rails.application.routes.draw do
  resource :users, only: [:create]
  post "/login", to: "users#alumni_login"
  post "/signin", to: "users#company_login"
  post "/signup", to: "users#create"

end

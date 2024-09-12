Rails.application.routes.draw do
  resources :posts
  resources :users
  resources :comments


  root "users#index"
  post "/login", to:  "users#login"


  post "/new_post", to: "posts#create"

  resources :comments, only: [ :index, :create, :update, :destroy ]
end

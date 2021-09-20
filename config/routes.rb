Rails.application.routes.draw do
  get 'users_index', to: "users#index"
  post 'users_index', to: "users#index"
  devise_for :users
  root "welcome#index"
  resources :welcome, only: [:index]
  resources :posts
  get 'users_friend_requests', to: "users#friend_requests"
  get 'accept_request', to: "users#accept_request"
  resources :users
end

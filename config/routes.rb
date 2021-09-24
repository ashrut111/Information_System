Rails.application.routes.draw do
  get 'friends/index'
  root "welcome#index"
  devise_for :users
  resources :posts
  resources :users do
    resources :friend_requests
  end
  get 'welcome_index', to: "welcome#index"
end

Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "home#index", as: :authenticated_root
  end
  root "home#index"

  resources :posts, only: %i[new create show] do
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create]
  end
end

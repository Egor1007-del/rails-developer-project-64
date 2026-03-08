Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "home#index", as: :authenticated_root
  end
  root "home#index"

  namespace :account do
    resources :posts, only: %i[index new create show]
  end

  resources :posts, only: %i[show] do
    resource :like, only: %i[create destroy], controller: "likes"
    resources :comments, only: %i[create]
  end
end

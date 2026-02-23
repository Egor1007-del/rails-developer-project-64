Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "account/posts#index", as: :authenticated_root
  end
  root "home#index"

  namespace :account do
    resources :posts, only: %i[index new create show]
  end

  resources :posts, only: %i[index show]
end

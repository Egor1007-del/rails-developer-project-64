# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :posts, only: %i[new create show] do
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create]
  end
end

Rails.application.routes.draw do
  devise_for :users
  resources :dashboard, only: [:index]
  resources :language_users

  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
    resources :entries
  end

  namespace :api do
    resources :language_users
    resources :entries, only: [:index]
  end

  root to: "home#index"
end

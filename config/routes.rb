Rails.application.routes.draw do
  devise_for :users
  resources :dashboard, only: [:index]

  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  namespace :api do
    resources :language_users
  end

  root to: "home#index"
end

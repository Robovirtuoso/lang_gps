Rails.application.routes.draw do
  devise_for :users
  resources :dashboard, only: [:index]

  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  root to: "home#index"
end

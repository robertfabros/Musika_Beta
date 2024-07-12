Rails.application.routes.draw do
  root 'home#index'
  get 'search', to: 'search#index'
  # Custom routes for About and Contact pages
  get 'about', to: 'pages#show', slug: 'about', as: 'about'
  get 'contact', to: 'pages#show', slug: 'contact', as: 'contact'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users
  resources :artists
  resources :music, only: [:index, :show]
  resources :carts
  resources :orders
  resources :reviews
  resources :genres
  resources :comments


  # Using :slug instead of :id for Pages resource
  resources :pages, param: :slug, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

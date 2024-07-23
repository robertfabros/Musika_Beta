Rails.application.routes.draw do
  get 'webhooks/stripe'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  namespace :customers do
    resource :dashboard, only: :show
  end

  root 'home#index'
  get 'search', to: 'search#index'
  get 'about', to: 'pages#show', slug: 'about', as: 'about'
  get 'contact', to: 'pages#show', slug: 'contact', as: 'contact'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users
  resources :artists
  resources :cart_items, only: [:create, :update, :destroy]
  resource :cart, only: [:show] do
    post 'add_to_cart', on: :collection
    delete 'remove_from_cart', on: :collection
    patch 'update_cart', on: :collection
  end
  resources :music, only: [:index, :show] do
    post 'add_to_cart', to: 'carts#add_to_cart', on: :member
  end
  resources :orders, only: [:index, :show, :new, :create] do
    member do
      post 'pay'
      get 'success'
      get 'cancel'
    end
  end
  resources :reviews
  resources :genres
  resources :comments

  resources :provinces, only: [] do
    member do
      get 'taxes'
    end
  end

  # Using :slug instead of :id for Pages resource
  resources :pages, param: :slug, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

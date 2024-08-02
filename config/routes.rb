Rails.application.routes.draw do
  get 'orders/index'
  get 'orders/show'
  get 'orders/new'
  get 'shopping_carts/show'
  get 'shopping_carts/destroy'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'golf_courses/index', to: "golf_courses#index"
  root 'tee_times#index'
  resources :tee_times
  resources :golf_courses
  resources :shopping_carts, only: [:show, :create, :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'golf_courses/index', to: "golf_courses#index"
  root 'tee_times#index'
  resources :tee_times
  resources :golf_courses
  resources :accessories
  resources :combined_accessories
  resources :provinces
  resources :users
  resources :orders
  resources :shopping_carts, only: [:show] do
    member do
      post 'add_tee_time'
      post 'add_accessory'
      delete 'remove_tee_time'
      post 'add_accessory'
      delete 'remove_accessory'
    end
  end
  post 'payments/create_payment', to: 'payments#create_payment'
  get 'execute', to: 'payments#execute_payment'
  post 'payments/execute_payment', to: 'payments#execute_payment'
  get 'payments/success', to: 'payments#success', as: 'success'
  get "up" => "rails/health#show", as: :rails_health_check
end

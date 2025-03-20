Rails.application.routes.draw do
  get "sections/index"
  get "sections/new"
  get "sections/create"
  get "sections/edit"
  get "sections/update"
  get "sections/destroy"
  get "todo_items/index"
  get "todo_items/new"
  get "todo_items/create"
  get "todo_items/edit"
  get "todo_items/update"
  get "todo_items/destroy"
  resource :session
  resources :passwords, param: :token
  get "login" => "sessions#new", as: :login
  get "logout" => "sessions#destroy", as: :logout
  resource :registration, only: [ :new, :create ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"

  # Dashboard route
  get "dashboard" => "dashboard#index", as: :dashboard
  
  # Todo items routes
  get "todo_items/new_section" => "todo_items#new_section", as: :new_section_todo_item
  resources :todo_items

  # Profile route
  resource :profile, only: [ :edit, :update, :destroy ]

  # Delete profile confirmation
  get "delete_account_confirmation", to: "profiles#delete_account_confirmation"
end

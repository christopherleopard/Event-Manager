Rails.application.routes.draw do
  get '/facilities', to: 'pages#facilities'
  get '/special-education', to: 'pages#special_education'
  get '/food-service', to: 'pages#food_service'
  get '/food-service/menus', to: 'pages#menus'
  get '/food-service/family-resources', to: 'pages#family_resources'
  get '/kids-club', to: 'pages#kids_club'
  get "staffs/index"
  get "staffs/show"
  get "events/index"
  get "events/show"
  get "home/index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :admin do
    resources :staff, controller: "staffs", as: "staff"
    resources :board_minutes, path: "board-minutes", as: "board_minutes"
    resources :board_books, path: "board-books", as: "board_books"
    post "newsletter_urls/update", to: "newsletters#update", as: :newsletter_urls_update
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
  resources :events, only: [ :index, :show ]
  resources :staffs, only: [ :index, :show ]
  resources :board_minutes, only: [ :index, :show ]
  resources :board_books, only: [ :index, :show ]
  resources :emergency_alerts, only: [:index, :show, :create, :update, :destroy] do
    patch :activate, on: :member
  end
end

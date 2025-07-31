Rails.application.routes.draw do
  get '/facilities', to: 'pages#facilities'
  get "staffs/index"
  get "staffs/show"
  get "events/index"
  get "events/show"
  get "home/index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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

  namespace :admin do
    post "newsletter_urls/update", to: "newsletters#update", as: :newsletter_urls_update
  end
end

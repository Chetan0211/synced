Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :user, except: [:index]
  resources :session, only: [:new, :create]

  get "log_out" => "session#log_out", as: :session_log_out

  namespace :admin do
    get "dashboard" => "dashboard#index", as: :dashboard
    resources :students, only: [:index]
  end

  namespace :student do
    get "dashboard" => "dashboard#index", as: :dashboard
    resources :signup, only: [:new, :create]
  end

  namespace :teacher do
    get "dashboard" => "dashboard#index", as: :dashboard
  end

  # Defines the root path route ("/")
  root "home#index"
end

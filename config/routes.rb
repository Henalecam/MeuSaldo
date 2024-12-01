Rails.application.routes.draw do
  get "notices/index"
  get "notices/show"
  get "notices/search"
  get "sessions/new"
  devise_for :users

  get "/login", to: "sessions#new"
  resources :users, only: [ :show, :edit, :update ]
  resources :categories, only: [ :index, :new, :create, :edit, :update, :destroy ]
  resources :transactions, only: [ :index, :new, :create, :edit, :update, :destroy ]
  resources :dashboards, only: [ :index ]
  resources :cryptos, only: [:index, :show] do
    collection do
      post :update_prices # Para criar a ação de atualização
    end
  end
  resources :notices, only: [:index, :show, :create] do
    collection do
      get :search
    end
  end
  resources :lots, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

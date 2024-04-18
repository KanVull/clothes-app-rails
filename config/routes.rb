Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # catalog
  root to: "catalog#index"
  get "/catalog(/:category_slug)", to: "catalog#index", as: "catalog"
  resources :products, only: %i[show]

  # users
  resources :users, only: %i[new create]
  resources :user_activations, only: %i[new edit]
  resources :password_resets, only: %i[new create edit update]
  get "/password_reset_success", to: "password_resets#mail_sent", as: "mail_sent"
  get "/profile", to: "profile#index", as: "profile"
  resources :sessions, only: %i[new create]
  resource :session, to: "sessions#destroy", only: %i[destroy], defaults: { id: nil }

  # carts and orders
  resource :cart, only: %i[show update]
  resources :orders, only: %i[new create]
  get "/orders/:uuid", to: "orders#show", as: "order_by_uuid"

  # admin pages
  namespace "admin" do
    get "/", to: "home#index"
    resources :products
    resources :product_categories
    resources :carts, only: %i[index show destroy]
    resources :orders, only: %i[index show destroy]
    resources :users, only: %i[index show edit update destroy] do
      resources :orders, only: %i[index]
    end
  end

  match "*unmatched", to: "application#render_404", via: :all
end

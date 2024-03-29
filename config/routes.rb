Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "/catalog(/:category_slug)", to: "catalog#index", as: "catalog"
  resources :products, only: %i[show]

  resource :cart, only: %i[show update]

  resources :orders, only: %i[new create]
  get "/orders/:uuid", to: "orders#show", as: "order_by_uuid"

  namespace "admin" do
    get "/", to: "home#index"
    resources :products
    resources :product_categories
    resources :carts, only: %i[index show destroy]
    resources :orders, only: %i[index show destroy]
  end

  match "*unmatched", to: "application#render_404", via: :all
end

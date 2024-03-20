Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "/catalog(/:category_name)", to: "catalog#index", as: "catalog"

  resource :cart, only: %i[show update]
  resources :orders

  get "/admin", to: "admin#dashboard"
  namespace "admin" do
    resources :products
    resources :product_categories
    resources :carts, only: %i[index show destroy]
    resources :orders, only: %i[index show destroy]
  end

  match "*unmatched", to: "application#render_404", via: :all
end

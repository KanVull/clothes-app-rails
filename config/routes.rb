Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "/catalog(/:category_name)", to: "catalog#index", as: "catalog"

  # post '/add_to_cart/:product_id', to: 'carts#update', as: 'add_to_cart'
  resource :cart, only: %i[show update]

  get "/admin", to: "admin#dashboard"
  namespace "admin" do
    resources :products
    resources :product_categories
  end

  match "*unmatched", to: "application#render_404", via: :all
end

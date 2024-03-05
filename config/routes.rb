Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/catalog(/:category_name)", to: "catalog#index", as: "catalog"

  get "/admin", to: "admin#dashboard"
  namespace "admin" do
    resources :products
  end

  match "*unmatched", to: "application#render_404", via: :all
end

# /
# /catalog
# /catalog/:id

# /catalog/category_1
# /catalog/category_2

# /products/:id

# GET /cart
# PUT /cart

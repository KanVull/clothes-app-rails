Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :catalog, only: [ :index ] do
    get "/", to: "catalog#index", on: :collection
  end

  resources :catalog, only: [ :show ], param: :category_name do
    get "/", to: "catalog#show", on: :member
  end
end

# /
# /catalog
# /catalog/:id

# /catalog/category_1
# /catalog/category_2

# /products/:id

# GET /cart
# PUT /cart

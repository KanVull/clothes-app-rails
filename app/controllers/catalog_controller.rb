class CatalogController < ApplicationController
  include Pagy::Backend
  
  def index
    @title = "Store - catalog"
    @pagy, @products = pagy(Product.published, items: 3)
    @product_categories = ProductCategory.with_published_products
    render "index"
  end

  def show
    @title = "Store - #{params[:name]}"
    category = ProductCategory.find_by!(name: params[:name])
    @pagy, @products = pagy(category.products.published, items: 3)
    @product_categories = ProductCategory.with_published_products
    render "index"
  end
end

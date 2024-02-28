class CatalogController < ApplicationController
  def index
    @title = "Store - catalog"
    @products = Product.published
    @product_categories = ProductCategory.with_published_products
    render "index"
  end

  def show
    @title = "Store - #{params[:name]}"
    category = ProductCategory.find_by!(name: params[:name])
    @products = category.products.published
    @product_categories = ProductCategory.with_published_products
    render "index"
  end
end

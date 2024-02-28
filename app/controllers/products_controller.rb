class ProductsController < ApplicationController
  def index
    @title = "Store - catalog"
    @products = Product.all
    @product_categories = ProductCategory.all
  end
end
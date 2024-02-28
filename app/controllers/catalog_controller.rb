class CatalogController < ApplicationController
    def index
      @title = "Store - catalog"
      @products = Product.published.all
      @product_categories = ProductCategory.all
      render 'index'
    end

    def show
      @title = "Store - #{params[:name]}" 
      category = ProductCategory.find_by!(name: params[:name])
      @products = category.products.published
      @product_categories = ProductCategory.all
      render 'index'
    end
  end
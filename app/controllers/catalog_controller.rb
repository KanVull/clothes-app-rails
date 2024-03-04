require_relative "../services/products_filter.rb"

class CatalogController < ApplicationController
  include Pagy::Backend

  def index
    @title = "Store - Catalog"
    products = Product.published
    filter_products(products)
    @form_action_path = catalog_index_path
    render "index"
  end

  def show
    @title = "Store - #{params[:category_name]}"
    products = Product.published.in_category(params[:category_name])
    filter_products(products)
    @form_action_path = catalog_path(params[:category_name])
    render "index"
  end

  private

  def filter_products(products)
    if params[:product_filter].present?
      products = ProductsFilter.new(products, params[:product_filter]).filter
    end

    @pagy, @products = pagy(products, items: 3)
    @product_categories = ProductCategory.with_published_products.order(:name)
  end
end

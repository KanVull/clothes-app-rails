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
    @title = "Store - #{params[:name]}"
    category = find_product_category_by_name
    products = category.products.published
    filter_products(products)
    @form_action_path = catalog_path(params[:name])
    render "index"
  end

  private

  def filter_products(products)
    products = apply_query_filter(products)
    products = apply_price_filters(products)

    @pagy, @products = pagy(products, items: 3)
    @product_categories = ProductCategory.with_published_products
  end

  def apply_price_filters(products)
    min_price = params[:min_price].present? ? params[:min_price].to_f : 0
    max_price = params[:max_price].present? ? params[:max_price].to_f : 100000000
    products.where(price: min_price..max_price)
  end

  def apply_query_filter(products)
    return products unless params[:query].present?

    products.where("name ILIKE ?", "%#{params[:query]}%")
  end

  def find_product_category_by_name
    ProductCategory.find_by!(name: params[:name])
  end
end

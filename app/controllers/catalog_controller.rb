require_relative "../services/products_filter.rb"

class CatalogController < BaseController
  include Pagy::Backend

  def index
    @f_params = filter_params
    if params[:category_name].present?
      ProductCategory.find_by_name!(params[:category_name])

      @title = "Store - #{params[:category_name]}"
      @f_params = @f_params.merge({ category_name: params[:category_name] })
    else
      @title = "Store - Catalog"
    end
    @filter = ProductsFilter.new(@f_params)
    @products = @filter.filter(Product.all)
    show_products_categories
    render "index"
  end

  private

  def show_products_categories
    @pagy, @products = pagy(@products, items: 3)
    @product_categories = ProductCategory.with_published_products.order(:name)
  end

  def filter_params
    params.fetch(:product_filter, {}).permit(:query, :min_price, :max_price)
  end
end

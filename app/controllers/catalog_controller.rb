class CatalogController < ApplicationController
  include Pagy::Backend

  def index
    @f_params = filter_params
    if params[:category_slug].present?
      pc = ProductCategory.find_by_slug!(params[:category_slug])

      @title = "Store - #{pc.name}"
      @f_params = @f_params.merge({ category_slug: params[:category_slug] })
    else
      @title = "Store - Catalog"
    end
    @filter = ProductsFilter.new(@f_params)
    @products = @filter.filter(Product.all)
    show_products_categories
  end

  private

  def show_products_categories
    @pagy, @products = pagy(@products, items: 6)
    @product_categories = ProductCategory.with_published_products.order(:name)
  end

  def filter_params
    params.fetch(:product_filter, {}).permit(:query, :min_price, :max_price)
  end
end

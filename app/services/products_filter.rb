class ProductsFilter
  attr_reader :products, :params

  def initialize(products, params)
    @products = products
    @params = params
  end

  def filter
    filtered_products = products
    filtered_products = filtered_products.where_name_is_like(params[:query]) if params[:query].present?
    filtered_products = filtered_products.min_price_gte(params[:min_price]) if params[:min_price].present?
    filtered_products = filtered_products.max_price_lte(params[:max_price]) if params[:max_price].present?
    filtered_products
  end
end

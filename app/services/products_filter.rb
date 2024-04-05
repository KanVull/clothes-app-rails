class ProductsFilter
  include ActiveModel::Model

  attr_accessor :query, :min_price, :max_price, :category_slug

  def initialize(params = {})
    # super
    @category_slug ||= params[:category_slug]
    @query ||= params[:query]
    @min_price ||= params[:min_price]
    @max_price ||= params[:max_price]
  end

  def filter(products)
    filtered_products = products
    filtered_products = filtered_products.in_category(@category_slug) if @category_slug.present?
    filtered_products = filtered_products.where_name_is_like(@query) if @query.present?
    filtered_products = filtered_products.min_price_gte(@min_price) if @min_price.present?
    filtered_products = filtered_products.max_price_lte(@max_price) if @max_price.present?
    filtered_products
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "ProductFilter")
  end
end

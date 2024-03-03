class ProductFilterForm
  include ActiveModel::Model

  attr_accessor :query, :min_price, :max_price

  def self.model_name
    ActiveModel::Name.new(self, nil, "ProductFilter")
  end
end

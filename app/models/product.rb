class Product < ApplicationRecord
  belongs_to :product_category

  validates :name, :price, :quantity, :product_category_id, presence: true

  scope :published, -> { where("published_at <= ?", Time.zone.now) }
  scope :in_category, ->(category_name) { where(product_category_id: ProductCategory.where(name: category_name)) }
  scope :where_name_is_like, ->(name) { where("name ILIKE ?", "%#{name}%") if name.present? }
  scope :min_price_gte, ->(min_price) { where("price >= ?", min_price) if min_price.present? }
  scope :max_price_lte, ->(max_price) { where("price <= ?", max_price) if max_price.present? }

  def published?
    published_at.present? && published_at <= Time.zone.now
  end

  def category
    product_category.name if product_category
  end
end

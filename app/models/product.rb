class Product < ApplicationRecord
  include ImageUrl

  belongs_to :product_category
  has_many :cart_products, dependent: :destroy
  has_many :order_products
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :product_category_id, presence: true

  scope :published, -> { where("published_at <= ?", Time.zone.now) }
  scope :where_name_is_like, ->(name) { where("name ILIKE ?", "%#{name}%") if name.present? }
  scope :min_price_gte, ->(min_price) { where("price >= ?", min_price) if min_price.present? }
  scope :max_price_lte, ->(max_price) { where("price <= ?", max_price) if max_price.present? }

  def published?
    published_at.present? && published_at <= Time.zone.now
  end

  def category
    product_category.slug if product_category
  end

  def self.in_category(category_slug)
    category = ProductCategory.find_by_slug(category_slug)
    where(product_category: category.subtree)
  end
end

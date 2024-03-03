class Product < ApplicationRecord
  belongs_to :product_category

  scope :published, -> { where("published_at <= ?", Time.zone.now) }
  scope :where_name_is_like, ->(name) { where("name ILIKE ?", "%#{name}%") if name.present? }
  scope :min_price_gte, ->(min_price) { where("price >= ?", min_price) if min_price.present? }
  scope :max_price_lte, ->(max_price) { where("price <= ?", max_price) if max_price.present? }

  def published?
    published_at.present? && published_at <= Time.zone.now
  end
end

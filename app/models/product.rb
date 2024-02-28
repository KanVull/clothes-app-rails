class Product < ApplicationRecord
    belongs_to :product_category

    scope :published, -> { where('published_at <= ?', Time.zone.now) }

  def published?
    published_at.present? && published_at <= Time.zone.now
  end
end
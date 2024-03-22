class ProductCategory < ApplicationRecord
  has_many :products, dependent: :destroy

  before_validation :parameterize_name

  validates :name, :shown_name, presence: true
  validates :name, :shown_name, uniqueness: true

  scope :with_published_products, -> { joins(:products).merge(Product.published).distinct }

  def ransackable_associations(auth_object = nil)
    Rails.logger.info("WITHIN RANSACK ASSOCIATION")
    super + %w[impressionable]
  end

  private

  def parameterize_name
    self.name = shown_name.present? ? shown_name.parameterize : nil
  end
end

class Product < ApplicationRecord
    belongs_to :product_category
    
    scope :published, -> { where(published: true) }
end
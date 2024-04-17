class User < ApplicationRecord
  include ImageUrl

  has_many :orders
  has_one :cart
  has_secure_password
  has_one_attached :image

  def admin?
    is_admin
  end
end

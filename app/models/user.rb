class User < ApplicationRecord
  has_many :orders
  has_one :cart
  has_secure_password

  def admin?
    is_admin
  end
end

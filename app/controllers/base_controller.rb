class BaseController < ApplicationController
  before_action :set_cart

  def set_cart
    Current.cart = Cart.find_or_create_by(session_key: session.id.to_s)
  end
end

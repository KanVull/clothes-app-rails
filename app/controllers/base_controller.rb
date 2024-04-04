class BaseController < ApplicationController
  before_action :set_cart

  private

  def set_cart
    if user = current_user
      Current.cart = Cart.find_or_create_by(user_id: user.id)
      if cart2 = Cart.find_by(session_key: session.id.to_s)
        Current.cart.merge!(cart2)
      end
    else
      Current.cart = Cart.find_or_create_by(session_key: session.id.to_s)
    end
  end
end

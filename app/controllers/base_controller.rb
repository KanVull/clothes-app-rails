class BaseController < ApplicationController
  before_action :set_user
  before_action :set_cart

  private

  def set_user
    if cookies.signed["user_id"].present?
      Current.user = User.find(cookies.signed[:user_id])
    end
  end

  def set_cart
    Current.cart = Cart.find_or_create_by(session_key: session.id.to_s)
  end
end

class ApplicationController < ActionController::Base
  include Pagy::Backend
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  before_action :set_cart

  def render_404
    render file: "#{Rails.root}/public/404.html",  status: 404
  end

  def set_cart
    Current.cart = Cart.find_or_create_by(session_key: session.id.to_s)
  end
end

class ApplicationController < ActionController::Base
  include Pagy::Backend
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404
    render file: "#{Rails.root}/public/404.html",  status: 404
  end

  protected

  def require_user!
    unless current_user
      redirect_to new_session_path, alert: "Please sign in to get access to this page!"
    end
  end

  def current_user
    return Current.user if Current.user

    Current.user = if cookies.signed["user_id"].present?
      find_user_from_cookies
    elsif request.headers["Authorization"].present?
      find_user_from_jwt_token
    end
  end
  helper_method :current_user

  def find_user_from_cookies
    User.find(cookies.signed["user_id"])
  rescue => _e
    nil
  end

  def find_user_from_jwt_token
    token = http_header_token
    payload = JwtService.decode(token)
    user_id = payload.dig(0, "user_id")

    User.find(user_id)
  rescue => _e
    nil
  end

  def current_cart
    return Current.cart if Current.cart

    if user = current_user
      Current.cart = Cart.find_or_create_by(user_id: user.id)
      if cart2 = Cart.find_by(session_key: session.id.to_s)
        Current.cart.merge!(cart2)
      end
    else
      Current.cart = Cart.find_or_create_by(session_key: session.id.to_s)
    end

    Current.cart
  end
  helper_method :current_cart

  private

  def http_header_token
    pattern = /^Bearer /
    header  = request.headers["Authorization"]
    header.gsub(pattern, "") if header&.match(pattern)
  end
end

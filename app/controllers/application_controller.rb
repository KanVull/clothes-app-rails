class ApplicationController < ActionController::Base
  include Pagy::Backend
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  before_action :set_current_user

  def render_404
    render file: "#{Rails.root}/public/404.html",  status: 404
  end

  def require_user!
    unless Current.user
      redirect_to new_session_path, alert: "Please sign in to get access to this page!"
    end
  end

  def set_current_user
    return if Current.user

    Current.user = if cookies.signed["user_id"].present?
      find_user_from_cookies
    elsif request.headers["Authorization"].present?
      find_user_from_jwt_token
    end
  end

  def find_user_from_cookies
    User.find(cookies.signed["user_id"])
  rescue => e
    nil
  end

  def find_user_from_jwt_token
    token = http_header_token
    payload = JwtService.decode(token)
    user_id = payload.dig(0, "user_id")

    User.find(user_id)
  rescue => e
    nil
  end

  private

  def http_header_token
    pattern = /^Bearer /
    header  = request.headers["Authorization"]
    header.gsub(pattern, "") if header&.match(pattern)
  end
end

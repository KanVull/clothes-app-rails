class ApplicationController < ActionController::Base
  include Pagy::Backend
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404
    render file: "#{Rails.root}/public/404.html",  status: 404
  end

  def authenticate_user
    if cookies.signed["user_id"].present?
      Current.user = User.find_by!(id: cookies.signed[:user_id])
    elsif request.headers["Authorization"].present?
      authenticate_user_from_jwt_token
    else
      redirect_to new_session_path, alert: "You must be logged in!"
    end
  end

  def authenticate_user_from_jwt_token
    token = http_header_token
    payload = JwtService.decode(token)
    user_id = payload.dig(0, "user_id")
    Current.user = User.find_by!(id: user_id)
  rescue => e
    redirect_to new_session_path, alert: "You must be logged in!"
  end

  private

  def http_header_token
    pattern = /^Bearer /
    header  = request.headers["Authorization"]
    header.gsub(pattern, "") if header&.match(pattern)
  end
end

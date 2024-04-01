class ApplicationController < ActionController::Base
  include Pagy::Backend
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404
    render file: "#{Rails.root}/public/404.html",  status: 404
  end

  def authenticate_user_from_token
    token = cookies.signed[:token]
    payload = JwtService.decode(token)
    user_id = payload.dig(0, "user_id")
    Current.user = User.find_by!(id: user_id)
  rescue => e
    redirect_to new_session_path, alert: "You must be logged in!"
  end
end

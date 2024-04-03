class Admin::BaseController < ApplicationController
  before_action :require_user!
  before_action :require_admin!

  layout "admin"

  private

  def require_admin!
    unless current_user&.admin?
      redirect_to new_session_path, alert: "You must be an admin to access this page. If you require access, please contact the administrator."
    end
  end
end

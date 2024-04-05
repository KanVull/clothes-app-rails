class Admin::BaseController < ApplicationController
  before_action :require_user!
  before_action :require_admin!

  layout "admin"

  private

  def require_admin!
    unless current_user&.admin?
      flash[:warning] = "You must be an admin to access this page. If you require access, please contact the administrator."
      redirect_to new_session_path
    end
  end
end

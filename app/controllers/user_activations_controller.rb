class UserActivationsController < ApplicationController
  def new
    user = current_user
    user.update_activation_digest
    user.send_activation_email
    flash[:info] = "Activation link was send to your email!"
    redirect_back fallback_location: profile_path
  end

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to profile_path
    else
      flash[:warning] = "Invalid activation link"
      redirect_to root_path
    end
  end
end

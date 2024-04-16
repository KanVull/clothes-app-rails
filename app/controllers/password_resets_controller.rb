class PasswordResetsController < ApplicationController
  before_action :get_user, only: %i[edit update]
  before_action :valid_user, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def new
  end

  def create
    @user = User.find_by_email(password_reset_params[:email])
    if @user
      @user.create_reset_password_digest
      @user.send_password_reset_email
    end
    redirect_to mail_sent_path
  end

  def edit
  end

  def update
    if @user.update(user_password_params)
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to profile_path
    else
      flash.now[:warning] = "Password and confirmation password do not match. Please make sure they are identical and try again."
      render "edit"
    end
  end

  def mail_sent
    render "mail_sent"
  end

  private

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    redirect_to root_url unless @user&.authenticated?(:reset_password, params[:id])
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:warning] = "Password reset has expired. Send new reset link ot your email."
      redirect_to new_password_reset_url
    end
  end

  def password_reset_params
    params.require(:password_reset).permit(:email)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User successfully created. Please log in."
      redirect_to new_session_path
    else
      render :new
    end
  end

  def update_profile_image
    user = User.find(params[:user_id])
    if user.update(image_params)
      flash[:success] = "Profile updated"
    else
      flash[:info] = "Cann't update your profile picture, try another picture"
    end
    redirect_to profile_path
  end

  def remove_profile_image
    user = User.find(params[:user_id])
    user.image.purge
    redirect_back fallback_location: request.referrer
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def image_params
    params.require(:user).permit(:image)
  end
end

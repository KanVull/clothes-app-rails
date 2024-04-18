class ProfileImagesController < ApplicationController
  def update
    user = User.find(params[:id])
    p = image_params
    if p.nil?
      flash[:info] = "Choose your image first"
      redirect_back fallback_location: request.referrer
      return
    end
    if user.update(p)
      flash[:success] = "Profile updated"
    else
      flash[:info] = "Can't update your profile picture. Please try another picture."
    end
    redirect_back fallback_location: request.referrer
  end

  def destroy
    user = User.find(params[:id])
    user.image.purge
    redirect_back fallback_location: request.referrer
  end

  private

  def image_params
    params.require(:user).permit(:image)
  rescue => _e
    nil
  end
end

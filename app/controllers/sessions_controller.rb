class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by!(email: params[:email])

    if user&.authenticate(params[:password])
      payload = { user_id: user.id }
      token = JwtService.encode(payload)
      cookies.signed[:token] = {
        value: token,
        expires: 7.days.from_now,
        httponly: true
      }
      redirect_to catalog_url, notice: "Logged in successfully!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    cookies.delete :token
    redirect_to catalog_url, notice: "Logged out successfully!"
  end
end

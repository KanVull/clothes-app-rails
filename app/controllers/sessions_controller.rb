class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      cookies.signed[:user_id] = {
        value: user.id,
        expires: 7.days.from_now,
        httponly: true
      }
      merge_cart
      flash[:success] = "Logged in successfully!"
      redirect_to catalog_url
    else
      flash.now[:warning] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    cookies.delete :user_id
    flash[:success] = "Logged out successfully!"
    redirect_to catalog_url
  end

  private
  
  def merge_cart
    cart = current_cart
    if session_cart = Cart.find_by(session_key: session.id.to_s)
      cart.merge!(session_cart)
    end
  end
end

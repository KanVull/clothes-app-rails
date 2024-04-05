class Admin::UsersController < Admin::BaseController
  before_action :set_user, except: [ :index ]

  def index
    @title = "Admin - Users"
    @users = User.all
  end

  def show
    @title = "Admin - User:#{params[:id]}"
  end

  def edit
    @title = "Admin - User:#{params[:id]}"
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User was successfully updated."
      redirect_to admin_user_path(@user)
    else
      flash.now[:warning] = "User wasn't updated!"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User was successfully deleted."
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :is_admin)
  end
end

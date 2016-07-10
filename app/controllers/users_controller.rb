class UsersController < ApplicationController
  def edit
  end

  def show
    set_user
  end

  def update
    set_user
    @user.update(update_params)
    redirect_to :root
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def update_params
    params.require(:user).permit(:name, :email, :password, :member, :profile, :works)
  end
end

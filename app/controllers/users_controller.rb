class UsersController < ApplicationController
  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(update_params)
    redirect_to :root
  end

  def update_params
    params.require(:user).permit(:name, :email, :password, :member, :profile, :works)
  end
end

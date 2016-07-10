class UsersController < ApplicationController
 before_action :set_user
 before_action :authenticate_user!

  def show
  end

  def edit
  end

  def update
    @user.update(update_params)
    redirect_to :root
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def update_params
    params.require(:user).permit(:name, :email, :password, :member, :profile, :works, :avatar)
  end
end

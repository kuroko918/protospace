class UsersController < ApplicationController
 before_action :set_user
 before_action :authenticate_user!

  def show
    @prototypes = @user.prototypes.includes(:tags).page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(update_params)
      redirect_to root_path, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def update_params
    params.require(:user).permit(:name, :email, :password, :member, :profile, :works, :avatar)
  end
end

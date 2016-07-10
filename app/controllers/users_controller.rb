class UsersController < ApplicationController
  def index
  end

  def edit
  end

  def show
  end

  def update
    current_user.update(update_params)
    redirect_to :root
  end

  def update_params
    params.require(:user).permit(:name, :email, :password, :member, :profile, :works)
  end
end

class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user)
  end

  def show
  end

  def new
    @prototype = Prototype.new
    @prototype.images.build
  end

  def create
    @prototype = Prototype.new(create_params)
    if @prototype.save
      redirect_to root_path, notice: 'exactly saved'
    else
      redirect_to new_prototype_path, alert: 'please post image'
    end
  end

  def edit
  end

  def update
    if @prototype.update(update_params)
      redirect_to root_path, notice: 'Updated Successfully'
    else
      render :edit
    end
  end

  def destroy
    if @prototype.destroy
      redirect_to root_path, notice: 'Deleted Successfully'
    else
    end
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def create_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      images_attributes: [:image, :status]
      ).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      images_attributes: [:image, :status]
      )
  end
end
